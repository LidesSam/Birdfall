extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.timeleft.start()
	actowner.player.timeover()
	#actowner.endPopup.show()
