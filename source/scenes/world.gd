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
	Global.score=0
	$hud/root.show()
	fsm.autoload(self)
	fsm.addStateTransition("startStage","onStage",countdown_over)
	fsm.addStateTransition("onStage","lossStage",loss)
	fsm.addStateTransition("onStage","completeStage",stage_is_complete)
	fsm.startState()

func _process(delta):
	fsm.fsmUpdate(delta)
	
#fsm flags	
func countdown_over():
	return countdown.time_left<=0
	
func stage_is_complete():
	return complete
	
func loss():
	return timeleft.timeout() or player.death
#setters
#autosetters
func complete_stage():
	complete = true
#manualsetters
#set_value(value)
#var = value
func auto_set_shadder():
	self.material=Global.currentShadder
	$hud/root.material =material
	$hud/root/time.material =Global.currentSecShadder
	#set sec material
	player.material=Global.currentSecShadder
	$Seeds.material=Global.currentSecShadder
	$triggers.material=Global.currentSecShadder
	
func update_hud():
	var scoretext="SCORE:"+ str("%06d" % Global.score)
	$hud/root/score.text = scoretext
	$hud/root/endpopup/ScoreLabel.text = scoretext
func show_full_hud():
	$hud/root/back.show()
	$hud/root/score.show()
	$hud/root/endpopup/ScoreLabel.show()
	timeleft.show()
#callbacks
func _on_back_button_pressed() -> void:
	ScreenTransition.change_scene_to_file("res://source/scenes/mainMenu.tscn")
	pass # Replace with function body.
