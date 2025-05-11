extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	super(actowner)
	actowner.play_animation("hang-on")
	actowner.velocity.y=0
	actowner.sideCollisionSensor.enabled=false
	if($peckSfx):
		$peckSfx.play()
		$peckSfx.pitch_scale= 0.6 + randi()%5-2*0.02

	
func update(actowner, delta):
	super(actowner, delta)
	actowner.velocity.y=0
	
func handleInput(actowner,event):
	super(actowner,event)
	actowner.jumpInput()
	
func exit(actowner):
	super(actowner)
	actowner.justHitWall=false
