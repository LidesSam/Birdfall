extends CharacterBody2D

# Called when the node enters the scene tree for the first time.
var DIR_LEFT = -1
var DIR_RIGHT = 1
var d=-1

var speed=200
var money=0

#reftoparentNodes
var hud=null
var tilemap=null

#lifepoints
var maxlp=3
var lp=0


var death=false
var dying=false
var inJump=false
var inGround =false
var onDropDown=false
var inPecking=false
var justHitWall = false	
var awaiting = true


@onready var fsm = $fsm
@onready var animation=$AnimatedSprite

@onready var sideCollisionSensor=$RayCastSide
@onready var dmgCooldown = $Timer
@onready var wasDamaged = false

func _ready():
	$AnimatedSprite.flip_h=true
	velocity= Vector2(0,100)
	
	fsm.set_owner(self)
	fsm.autoload(self)
	fsm.set_debug_on($lblstate)
	
	fsm.addGlobalTransition("die",isDying)
	
	fsm.addStateTransition("wait","idle",isNotAwaiting)
	fsm.addStateTransition("fall","idle",isOnGround)
	
	fsm.addStateTransition("idle","fall",isFalling)
	fsm.addStateTransition("jump","fall",isFalling)
	
	fsm.addStateTransition("idle","jump",inJumping)
	
	fsm.addStateTransition("idle","peck",isPecking)
	fsm.addStateTransition("jump","peck",isPecking)
	fsm.addStateTransition("fall","peck",isPecking)
	
	fsm.addStateTransition("peck","fall",outPecking)
	fsm.addStateTransition("peck","hang-wall",isToHangOn)
	
	fsm.addStateTransition("hang-wall","jump",inJumping)
	
	
	fsm.startState()
	
	maxlp =3
	lp=3
	
func wait_over():
	awaiting=false
	
func isNotAwaiting():
	return !awaiting
#state flags function
func isFalling():
	return !isOnGround() and velocity.y>0
	
func isPecking():
	return inPecking
func outPecking():
	return !inPecking
	
func isToHangOn():
	return isPecking() and hit_a_wall()
		
func hit_a_wall():
	return justHitWall	
	
func inJumping():
	return inJump

func isDying():
	return dying
	
func isOnGround():
	return inGround and !isDying()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func gravity_step():
	velocity.y-=-9.8
	if(velocity.y>=200):
		velocity.y=200

func _physics_process(delta):
	if(!isDying()):
		if(!hit_a_wall()):
			gravity_step()

		# Update grounded state from raycast
		var raycollider = $RayCast2D.get_collider()
		inGround = raycollider != null and raycollider == tilemap

		# Move character using Godot's built-in method
		if(!hit_a_wall()):
			move_and_slide()

		if !hit_a_wall() and sideCollisionSensor.enabled:
			#modulate = "#ff0"  # yellow while checking
			sideCollisionSensor.force_raycast_update()
			if sideCollisionSensor.is_colliding():
				#modulate = "#f0f"  # pink when colliding
				justHitWall = true
		# Check for collisions (e.g., item pickups)
		# Failsafe hazard check on collision position
		for i in range(get_slide_collision_count()):
			var collision = get_slide_collision(i)
			var collision_pos = collision.get_position()
			var tile_pos = tilemap.local_to_map(collision_pos)
			print("cheking group")
			var tile_data = tilemap.get_cell_tile_data(tile_pos)
			
			if tile_data:
				if tile_data.get_custom_data("group") == "hazard" and !isDying():
					print("dying:",dying)
					dying = true
					print("dying p:",dying)
			
	# Run FSM logic
	fsm.fsmUpdate(delta)	
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
	
	#if  event.is_action_pressed("ui_left"):
	#	d=-1
	#	velocity.x=-100 
	#	$AnimatedSprite.flip_h=false# invert afther remove pkaceholder
	#else:
	#	if  event.is_action_pressed("ui_right"):
	#		velocity.x=100 
	#		$AnimatedSprite.flip_h=true# invert afther remove pkaceholder
		
func jumpInput():
	if( Input.is_action_just_pressed("ui_back")):
		inJump=true
		inGround=false
		
func peckInput():
	if( Input.is_action_just_pressed("ui_action")):
		inPecking=true	
		
func sidemove():
	if (Input.is_action_pressed("ui_left")):
		d=DIR_LEFT
		$AnimatedSprite.flip_h=true 
	if (Input.is_action_pressed("ui_right")):
		d=DIR_RIGHT
		$AnimatedSprite.flip_h=false 
	if not(Input.is_action_pressed("ui_left")) and  not(Input.is_action_pressed("ui_right")):
		velocity.x=0
	else:
		velocity.x=speed*d

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


func _on_on_peck_timer_timeout() -> void:
	$onPeckTimer.stop()
	if(isPecking()):
		inPecking=false
	print("peck out")
	pass # Replace with function body.
