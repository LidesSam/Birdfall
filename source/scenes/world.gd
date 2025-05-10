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
@onready var endPopupLbl =$hud/root/endpopup/Label
@onready var endPopupScoreLbl =$hud/root/endpopup/ScoreLabel
@onready var complete = false

func _ready() -> void:
	fsm.autoload(self)
	fsm.addStateTransition("startStage","onStage",countdown_over)
	fsm.addStateTransition("onStage","lossStage",timeleft.timeout)
	
	fsm.addStateTransition("onStage","completeStage",stage_is_complete)
	fsm.startState()

func _process(delta):
	fsm.fsmUpdate(delta)
	
#fsm flags	
func countdown_over():
	return countdown.time_left<=0
	
func stage_is_complete():
	return complete

#setters
#autosetters
func complete_stage():
	complete = true
#manualsetters
#set_value(value)
#var = value
#callbacks
func _on_back_button_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/mainMenu.tscn")
	pass # Replace with function body.
