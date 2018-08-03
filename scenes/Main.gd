extends Node

export (PackedScene) var current_level

func _ready():
	
	var level = current_level.instance()
	$World.add_child(level)

	var camera = setup_camera()
	
	var player = load("res://scenes/entities/Player.tscn").instance()
	player.position =  level.get_node("PlayerSpawn").position
	
	player.connect("fuel_changed", $HUD, "update_fuelbar")
	player.connect("structural_changed", $HUD, "update_structural")
#
	add_signals_from_group("interactables", $HUD, "set_notification")
	
	add_signals_from_group("fuel_cells", player, "fuel_collected")
	add_signals_from_group("scrap",      player, "scrap_collected")
	add_signals_from_group("upgrade",    player, "upgrade_collected")
	
	player.get_node("Engine").add_child(camera)
	
	$World.add_child(player)
	
func setup_camera():
	var camera = Camera2D.new()
	camera.set_name("PlayerCam")
	camera.limit_left = 0
	camera.limit_right = 640
	camera.limit_bottom = 360
	camera.make_current()
	return camera
	

func add_signals_from_group(group_name, target, method):
	var group = get_tree().get_nodes_in_group(group_name)
	for item in group:
		item.connect(method, target, method)