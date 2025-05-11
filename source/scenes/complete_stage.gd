extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.timeleft.add_score_and_stop()
	actowner.endPopup.show()
	actowner.endPopupLbl.text = "complete!! thanks for playing" 
	actowner.update_hud()
	Musicbox.stop()
	
func update(actower,delta):
	super(actower,delta)
