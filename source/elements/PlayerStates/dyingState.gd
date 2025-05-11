extends "res://addons/fsmgear/source/FsmState.gd"

var act=null
func enter(actowner):
	print("dying")
	super(actowner)
	actowner.inJump=false
	actowner.inGround =false
	actowner.onDropDown=false
	actowner.inPecking=false
	actowner.justHitWall = false
	actowner.play_animation("dead")
	act=actowner
	if($deadSfx):
		$deadSfx.pitch_scale= 1 + randi()%5-2*0.02
		$deadSfx.play()
func _on_animated_sprite_animation_finished() -> void:
	if(act):
		act.death=true
