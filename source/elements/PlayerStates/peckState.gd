extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	actowner.play_animation("peck")
	actowner.sideCollisionSensor.enabled=true;
	actowner.sideCollisionSensor.target_position =Vector2(10*actowner.d,0);
	actowner.velocity= Vector2(300*actowner.d,0)
	actowner.inJump=false
	actowner.get_node("onPeckTimer").start()
	
	if($peckSfx):
		$peckSfx.play()
		$peckSfx.pitch_scale= 1.0 + (randi()%5)-2*0.05
	
	
func exit(actowner):
	super(actowner)
	actowner.velocity=Vector2(0,0)
	#actowner.sideCollisionSensor.enabled=false;
	actowner.inPecking=false
	actowner.get_node("onPeckTimer").stop()
