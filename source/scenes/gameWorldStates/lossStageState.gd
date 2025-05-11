extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	super(actowner)
	actowner.timeleft.start()
	actowner.player.timeover()
	actowner.endPopupLbl.text = "Tou Loss... Try Again..."
	actowner.endPopup.show()#move this toprocesss 
func update(actowner,delta):
	super(actowner,delta)
	#here check if anim finished and then show the endpopup
