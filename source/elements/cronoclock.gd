extends Area2D


@export var triggered=false

func _ready() -> void:
		$anim.play("idle")
		
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and !triggered:
		Global.add_def_time()
		triggered=true
		$anim.play("trigger")
	pass # Replace with function body.


func _on_anim_animation_finished() -> void:
	Global.random_shadder_change()
	pass # Replace with function body.
