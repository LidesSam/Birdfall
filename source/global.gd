extends Node

@onready var currentShadder= load("res://assets/shaders/metallic-blue.tres")
var world=null
func add_def_time():
	if(world):
		world.timeleft.add_secs(60)
	
