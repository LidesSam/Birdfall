extends "res://src/objects/Fsm/FsmState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	StateName="jump"
	pass # Replace with function body.

func enter(actowner):
	actowner.isGrounded=false
	StateName="jump"
	actowner.velocity.y=-300
	actowner.play_animation("jumping")
	actowner.isJump=false
	print("enterState:",StateName)
	pass


func update(actowner,delta):
	actowner.sidemove()
	
	
	if actowner.isGrounded:
		parentFsm.change_to_state("idle")
	else:
		if actowner.velocity.y>0:
#			print("vy",actowner.velocity.y)
			parentFsm.change_to_state("fall")
		
	pass

func exit(actowner):
	
	print("exitState:",StateName)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
