extends Node

@onready var currentShadder= preload("res://assets/shaders/metallic-blue.tres")
@onready var currentShadderIndex=0
@onready var currentSecShadder= preload("res://assets/shaders/crab.tres")
@onready var currentSecShadderIndex=0

@onready var shadders=[
	load("res://assets/shaders/metallic-blue.tres"),
	load("res://assets/shaders/GB.tres"),
	load("res://assets/shaders/gun-cassata.tres"),
	load("res://assets/shaders/crab.tres"),
	load("res://assets/shaders/Gamma-night.tres"),
	load("res://assets/shaders/bcym.tres")
	]

var world=null
var score=0

func add_def_time():
	if(world):
		world.timeleft.add_secs(15)
		
func add_score(points):
	score+=points
	if world:
		world.update_hud()
func random_shadder_change():
	var r = randi()%shadders.size()
	#asing main shadder
	while r==currentShadderIndex:
		r = randi()%shadders.size()
	currentShadderIndex=r
	currentShadder=shadders[r]
	#asingSecShadder
	while r==currentShadderIndex:
		r = randi()%shadders.size()
	currentSecShadderIndex=r
	currentSecShadder=shadders[r]
	if world:
		world.auto_set_shadder()
	
