extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.play_animation("fall")

func update(actowner,delta):
	actowner.sidemove()

func exit(actowner):
	super(actowner)
