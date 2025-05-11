extends Control


func ready():
	material= Global.currentShadder
	ScreenTransition.play_intro_anim("fill_up")
	$ScoreTag.text = "YourScore: " + str("%06d" % Global.Score)

func _process(delta: float) -> void:
	material= Global.currentShadder
	
func _on_new_game_btn_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/world.tscn")
	pass # Replace with function body.
