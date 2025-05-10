extends "res://addons/fsmgear/source/FsmState.gd"

#jumpstate
func enter(actowner):
	actowner.isGrounded=false
	actowner.isJump=false
	actowner.velocity.y=-300
	actowner.play_animation("jumping")
	


func update(actowner,delta):
	actowner.sidemove()

func exit(actowner):
	super(actowner)
