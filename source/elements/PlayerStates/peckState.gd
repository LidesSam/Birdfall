extends "res://addons/fsmgear/source/FsmState.gd"

func enter(actowner):
	actowner.play_animation("peck")
	actowner.sideCollisionSensor.enabled=true;
	actowner.sideCollisionSensor.target_position =Vector2(10*actowner.d,0);
	actowner.velocity= Vector2(300*actowner.d,0)
	actowner.inPecking=true
	actowner.inJump=false
	
	
func exit(actowner):
	#actowner.sideCollisionSensor.enabled=false;
	actowner.inPecking=false
