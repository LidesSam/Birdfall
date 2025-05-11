extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.inGround=false
	actowner.play_animation("fall")

func handleInput(actowner,event):
	super(actowner,event)
	actowner.peckInput()
	actowner.sidemove()

func update(actowner,delta):
	super(actowner,delta)

func exit(actowner):
	super(actowner)
