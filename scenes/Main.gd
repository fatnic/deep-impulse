extends Node

export (PackedScene) var current_level

func _ready():

	var level = current_level.instance()
	$World.add_child(level)

	var camera = Camera2D.new()
	camera.limit_left = 0
	camera.limit_right = 640
	camera.limit_bottom = 360
	camera.make_current()
	
	var player = load("res://scenes/entities/Player.tscn").instance()
	player.position =  level.get_node("PlayerSpawn").position
	
	player.get_node("Engine").add_child(camera)
	$World.add_child(player)