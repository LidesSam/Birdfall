extends "res://src/objects/Fsm/FsmState.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var downFlag=false

# Called when the node enters the scene tree for the first time.
func _ready():
	StateName="dmg"
	pass # Replace with function body.

func enter(actowner):
	StateName="dmg"
	actowner.play_animation("dmg")

	if(actowner.dmgCooldown.is_stopped()):
		actowner.dmgCooldown.start()
	actowner.velocity.x=0
	.enter(actowner)



func handleInput(actowner):
	actowner.jumpInput()
	
	


func update(actowner,delta):
#	actowner.sidemove()
	
	
	if (actowner.get_wasDamaged()==false):
		parentFsm.change_to_state("walk")	
		
		
func exit(actowner):
	
	print("exitState:",StateName)
	pass
