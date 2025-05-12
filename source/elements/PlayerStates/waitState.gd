extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.play_animation("idle")
	
func update(actowner,delta):
	super(actowner,delta)
