extends Node

func _ready():
	
	var camera = Camera2D.new()
	camera.limit_left = 0
	camera.limit_right = 640
	camera.limit_bottom = 360
	camera.make_current()
	
	var player = load("res://scenes/entities/Player.tscn").instance()
	player.position = Vector2(100, 340)
	
	player.get_node("Engine").add_child(camera)
	$World.add_child(player)