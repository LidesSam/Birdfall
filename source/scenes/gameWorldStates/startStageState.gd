extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.player.setTilemap(actowner.tilemap)
	Global.world =actowner
	actowner.hud = Global.currentShadder
	actowner.material = Global.currentShadder
	actowner.countdown.start()
	
func update(actowner,delta):
	super(actowner,delta)
	if actowner.countdown.time_left<=3:
		actowner.countdownLbl.text = str("%01d" % round(actowner.countdown.time_left))
		
func exit(actowner):
	super(actowner)
	actowner.countdownLbl.hide()
