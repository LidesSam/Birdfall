extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.timeleft.start()
	actowner.player.wait_over()
	
