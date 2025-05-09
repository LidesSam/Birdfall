extends "res://src/objects/Fsm/FsmState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#state to fall of one side platforms temporaty intangibility
var changeY=0
var gridSize=16
# Called when the node enters the scene tree for the first time.
func _ready():
	StateName="fall"
	pass # Replace with function body.

func enter(actowner):
	.enter(actowner)
	changeY=actowner.position.y+16
	StateName="dropDown"
	actowner.play_animation("fall")
	actowner.Tangible(false)
#	print("enterState:",StateName)
	
#	madesolid
	pass


func update(actowner,delta):
	actowner.sidemove()
	if actowner.isGrounded:
		parentFsm.change_to_state("idle")
	if actowner.position.y>=changeY:	
		parentFsm.change_to_state("fall")
	pass

func exit(actowner):
	actowner.Tangible(true)
	
	print("exitState:",StateName)
	pass
