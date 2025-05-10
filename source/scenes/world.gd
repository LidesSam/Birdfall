extends Node2D


@onready var tilemap= $TileMap
@onready var player= $player

func _ready() -> void:
	player.setTilemap(tilemap)
