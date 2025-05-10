extends Area2D


@export var triggered=false

func _ready() -> void:
		$anim.play("idle")
		
func _on_body_entered(body: Node2D) -> void:
	print("aloha 1")
	if body.is_in_group("player") and !triggered:
		Global.world.complete_stage()
		triggered=true
		$anim.play("trigger")
	pass # Replace with function body.
