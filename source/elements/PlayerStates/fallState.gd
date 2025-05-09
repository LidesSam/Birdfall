extends "res://src/objects/Fsm/FsmState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	StateName="fall"
	pass # Replace with function body.

func enter(actowner):
	
	StateName="fall"
	actowner.play_animation("fall")
	print("enterState:",StateName)
	pass


func update(actowner,delta):
	actowner.sidemove()
	if actowner.isGrounded:
		parentFsm.change_to_state("idle")
	pass

func exit(actowner):
	
	print("exitState:",StateName)
	pass
