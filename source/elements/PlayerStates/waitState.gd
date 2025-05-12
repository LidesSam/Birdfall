extends "res://addons/fsmgear/source/FsmState.gd"


func enter(actowner):
	actowner.play_animation("idle")
	actowner.inJump=false
	actowner.sideCollisionSensor.enabled=false
	super(actowner)
