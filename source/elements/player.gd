extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var bulletGen = preload("res://src/objects/bullet.tscn")
# Called when the node enters the scene tree for the first time.
var d=1
var velocity= Vector2(0,100)
var speed=200

#reftoparentNodes
var hud=null
var tilemap=null



#lifepoints
var maxlp=3
var lp=0
var death=false
var isJump=false
var isGrounded =false
var onDropDown=false
var money=0
onready var fsm = null


onready var animation=$AnimatedSprite
onready var dmgCooldown = $Timer
onready var wasDamaged = false

func _ready():
	$AnimatedSprite.flip_h=true
	
	
	velocity= Vector2(0,100)
	fsm =  load("res://src/objects/Fsm/Fsm.gd").new()
	fsm.set_owner(self)
#	fsm.setStates()
	fsm.addState("idle","res://src/objects/PlayerStates/idleState.gd")
	fsm.addState("jump","res://src/objects/PlayerStates/jumpState.gd")
	fsm.addState("fall","res://src/objects/PlayerStates/fallState.gd")
	fsm.addState("dropdown","res://src/objects/PlayerStates/dropDownState.gd")
	fsm.startState()
	fsm.addGlobalTransition("idle","testOnGround")
	isGrounded =true
	maxlp =3
	lp=3

	isGrounded
	
	play_animation("idle")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func Tangible(tangible = true):
	self.get_node("CollisionShape2D").disabled=!tangible
	onDropDown=!tangible
	
#	print("odd:",onDropDown)
func gravity_step():
	velocity.y-=-9.8
	if(velocity.y>=200):
		velocity.y=200

func _physics_process(delta):
	gravity_step()
#	if not(Input.is_action_pressed("ui_left")) and  not(Input.is_action_pressed("ui_right")):
#		velocity.x=0
#	if (Input.is_action_pressed("ui_left")):
#		velocity.x=-speed
#	if (Input.is_action_pressed("ui_right")):
#		velocity.x=speed
#	sidemove()

	var raycollider = $RayCast2D.get_collider()
	
#	print(raycollider )
	
	if(raycollider!=null):
		isGrounded=true
	else:
		isGrounded=false
#		print(raycollider )
	
	fsm.fsmUpdate(delta)

	velocity=move_and_slide(velocity,Vector2(0,-1))
	
#	collide in the place to pick items
# call both move_and methods
	var collision = move_and_collide(Vector2.ZERO)
	if collision:
		velocity = velocity.slide(collision.normal)
		if(collision.collider.has_method("is_in_group")):
			if(collision.collider.is_in_group("items")):
				pick_item(collision.collider)
	
		
	$Label.text=str("velocity.y:",velocity.y)	
func sidemove():
	if not(Input.is_action_pressed("ui_left")) and  not(Input.is_action_pressed("ui_right")):
		velocity.x=0
	else:
		velocity.x=speed*d
	if (Input.is_action_pressed("ui_left")):
		d=-1
		$AnimatedSprite.flip_h=false# invert afther remove pkaceholder
	if (Input.is_action_pressed("ui_right")):
		
		d=1
		$AnimatedSprite.flip_h=true# invert afther remove pkaceholder

func hurt(points):	
	lp-=lp
	if lp<=0:
		lp=0
		death=true
	if(hud!=null):
		hud.updatelives(lp,maxlp)
	
func _input(event):
	if( Input.is_action_just_pressed("ui_action")):
		var b = load("res://src/objects/bullet.tscn").instance()
		
		if(d==1):
			b.position= $RBPos.position+position
	
		else:
			
			b.position= $LBPos.position+position
		b.set_velocity( Vector2(250*d,0))
		get_parent().add_child(b)
#		print("bullet")
	
		
	fsm.handleInput()
	
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
		isJump=true
		isGrounded=false
#		print("jump")
func setHud(HUD):
	hud=HUD
	
func setTilemap(tmap):
	tilemap=tmap
	
func play_animation(animName):
	$lblanim.text= str("anim:"+animName)
	animation.play(animName)

func updateStateName(stateName=""):
	$lblstate.text= str("c-state: ",stateName ," j:",isJump," g:",isGrounded)


func testOnGround():
	if(fsm.getCurrentStateName()!="idle" and onDropDown==false):
		return isGrounded
	else:
		return false;
		
func pick_item(item):
		match(item.itemName):
			"coin":
				money+=item.points
				
				item.get_parent().remove_child(item)
				hud.update_money(money)
func get_wasDamaged():
#	print(fsm.currentStateAsignedName)
	
	return wasDamaged

func _on_Timer_timeout():
	print("foe timeout--------------------->")
	wasDamaged=false

	pass # Replace with function body.				
