extends "res://addons/fsmgear/source/FsmState.gd"
#idlestae

var downFlag=false

func enter(actowner):
	actowner.play_animation("idle")
	super(actowner)

func handleInput(actowner,event):
	super(actowner,event)
	actowner.jumpInput()

func update(actowner,delta):
	super(actowner,delta)
	actowner.sidemove()
	if(actowner.velocity.x==0):
		actowner.play_animation("idle")
	else:
		actowner.play_animation("walk")
		
func exit(actowner):
	super(actowner)
