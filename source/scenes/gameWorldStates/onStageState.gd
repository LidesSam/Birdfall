extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.timeleft.start()
	
	actowner.player.modulate="#f00"
	actowner.player.wait_over()
	print("idle:",actowner.player.awaiting)
