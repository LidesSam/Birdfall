extends Control


func _ready():
	material= Global.currentShadder
	ScreenTransition.play_intro_anim("fill_up")
	$ScoreTAG.text = "YourScore: " + str("%06d" % Global.score)


	
func _on_new_game_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/world.tscn")
	pass # Replace with function body.
