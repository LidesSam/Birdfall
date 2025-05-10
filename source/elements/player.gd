extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
var d=1
var speed=200

#reftoparentNodes
var hud=null
var tilemap=null

#lifepoints
var maxlp=3
var lp=0
var death=false
var inJump=false
var inGround =false
var onDropDown=false
var money=0

@onready var fsm = $fsm


@onready var animation=$AnimatedSprite
@onready var dmgCooldown = $Timer
@onready var wasDamaged = false

func _ready():
	$AnimatedSprite.flip_h=true
	velocity= Vector2(0,100)
	
	fsm.set_owner(self)
	fsm.autoload(self)
	fsm.set_debug_on($lblstate)
	
	fsm.addGlobalTransition("idle",isOnGround)
	fsm.addGlobalTransition("fall",isFalling)
	
	fsm.addStateTransition("idle","jump",inJumping)
	
	fsm.startState()
	
	maxlp =3
	lp=3
	
#state flags function
func isFalling():
	return velocity.y>0
		
func inJumping():
	return inJump

func isOnGround():
	return inGround
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gravity_step():
	velocity.y-=-9.8
	if(velocity.y>=200):
		velocity.y=200

func _physics_process(delta):
	gravity_step()

	# Update grounded state from raycast
	var raycollider = $RayCast2D.get_collider()
	inGround = raycollider != null and raycollider == tilemap

	# Run FSM logic
	fsm.fsmUpdate(delta)

	# Move character using Godot's built-in method
	move_and_slide()

	# Check for collisions (e.g., item pickups)
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
#		if collision.collider.has_method("is_in_group") and collision.collider.is_in_group("items"):
#			pick_item(collision.collider)

func hurt(points):	
	lp-=points
	if lp<=0:
		lp=0
		death=true
	if(hud!=null):
		hud.updatelives(lp,maxlp)
	
#inputs
func _input(event):		
	fsm.handleInput(event)
	
	if  event.is_action_pressed("ui_left"):
		d=-1
		velocity.x=-100 

		$AnimatedSprite.flip_h=false# invert afther remove pkaceholder
	else:
		if  event.is_action_pressed("ui_right"):
			
			velocity.x=100 
			$AnimatedSprite.flip_h=true# invert afther remove pkaceholder
		
func jumpInput():
	if( Input.is_action_just_pressed("ui_back")):
		inJump=true
		inGround=false
		
func sidemove():
	if not(Input.is_action_pressed("ui_left")) and  not(Input.is_action_pressed("ui_right")):
		velocity.x=0
	else:
		velocity.x=speed*d
	if (Input.is_action_pressed("ui_left")):
		d=-1
		$AnimatedSprite.flip_h=true # invert afther remove pkaceholder
	if (Input.is_action_pressed("ui_right")):
		
		d=1
		$AnimatedSprite.flip_h=false # invert afther remove pkaceholder

func setHud(HUD):
	hud=HUD
	
func setTilemap(tmap:TileMapLayer):
	tilemap=tmap
	
func play_animation(animName):
	$lblanim.text= str("anim:"+animName)
	animation.play(animName)

			
func pick_item(item):
		match(item.itemName):
			"coin":
				money+=item.points
				item.get_parent().remove_child(item)
				if(hud):
					hud.update_money(money)
				
func get_wasDamaged():
	return wasDamaged

func _on_Timer_timeout():
	wasDamaged=false
	
func timeover():
	death=true
	play_animation("death")
