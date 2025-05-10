extends Node2D


@onready var tilemap= $TileMap
@onready var player= $player
@onready var fsm= $fsm

#used to asing material
@onready var hud =$hud/root
#display and handle time left
@onready var timeleft= $hud/root/time
#start level countdown display and timer respectively
@onready var countdownLbl =$hud/root/countLBL
@onready var countdown =$hud/root/countdownTimer

@onready var endPopup =$hud/root/endpopup

func _ready() -> void:
	fsm.autoload(self)
	fsm.addStateTransition("startStage","onStage",countdown_over)
	fsm.addStateTransition("onStage","lossStage",timeleft.timeout)
	fsm.startState()

func _process(delta):
	fsm.fsmUpdate(delta)
	
#fsm flags	
func countdown_over():
	return countdown.time_left<=0

func _on_back_button_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/mainMenu.tscn")
	pass # Replace with function body.
