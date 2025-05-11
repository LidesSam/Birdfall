extends Area2D

func _ready() -> void:
	$anim.play("default")


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		Global.add_score(100)
		hide()
		$CollisionShape2D.disabled=true
	pass # Replace with function body.
