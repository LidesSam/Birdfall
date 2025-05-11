extends Node

@onready var currentShadder= load("res://assets/shaders/metallic-blue.tres")

@onready var shadders=[
	load("res://assets/shaders/metallic-blue.tres"),
	load("res://assets/shaders/GB.tres"),
	load("res://assets/shaders/gun-cassata.tres"),
	load("res://assets/shaders/crab.tres"),
	]
@onready var currentShadderIndex=0
var world=null
func add_def_time():
	if(world):
		world.timeleft.add_secs(60)

func random_shadder_change():
		var r = randi()%shadders.size()
		while r==currentShadderIndex:
			r = randi()%shadders.size()
		currentShadderIndex=r
		currentShadder=shadders[r]
		if world:
			world.auto_set_shadder()
	
