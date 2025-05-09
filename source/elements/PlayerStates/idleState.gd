extends "res://src/objects/Fsm/FsmState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var downFlag=false

# Called when the node enters the scene tree for the first time.
func _ready():
	StateName="sidemoves"
	pass # Replace with function body.

func enter(actowner):
	StateName="idle"
	actowner.play_animation("idle")
	.enter(actowner)
	self
	print("enterState:",StateName)
	pass

func handleInput(actowner):
	actowner.jumpInput()
	if Input.is_action_pressed("ui_down"):
		downFlag=true
	else:
		downFlag=false
	


func update(actowner,delta):
	actowner.sidemove()
	if(actowner.velocity.x==0):
		actowner.play_animation("idle")
	else:
		actowner.play_animation("walk")
	pass
	
	if  (not actowner.isGrounded):
		parentFsm.change_to_state("fall")
	
	if (actowner.isJump):
#		print("downFlag")
		if(downFlag):
			parentFsm.change_to_state("dropdown")
			downFlag=false
			actowner.isJump=false
		else:
			parentFsm.change_to_state("jump")
	
func exit(actowner):
	
	print("exitState:",StateName)
	pass
