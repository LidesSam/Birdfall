extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.timeleft.stop()
	actowner.endPopup.show()
	actowner.endPopupLbl.text = "complete!! thanks for playing"
	
func update(actower,delta):
	super(actower,delta)
