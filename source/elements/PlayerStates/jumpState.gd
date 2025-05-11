extends "res://addons/fsmgear/source/FsmState.gd"

#jumpstate
func enter(actowner):
	actowner.inGround=false
	actowner.velocity.y=-300
	actowner.sideCollisionSensor.enabled=false
	actowner.play_animation("jumping")
	if($jumpSfx):
		$jumpSfx.play()
		$jumpSfx.pitch_scale= 1.0 + randi()%5-2*0.05
	
	
func handleInput(actowner,event):
	super(actowner,event)
	actowner.peckInput()
	actowner.sidemove()

func update(actowner,delta):
	actowner.sidemove()

func exit(actowner):
	super(actowner)
