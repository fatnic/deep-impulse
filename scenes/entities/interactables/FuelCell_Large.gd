extends "res://scenes/entities/interactables/base/Interactable.gd"

export (float) var fuel_amount = 50

signal fuel_collected

func _ready():
	pass

func entered(body):
	print(body.get_name(), " is in range")
	
	
func exited(body):
	print(body.get_name(), " is not in range")
	
	
func interacting():
	not_interactive()
	emit_signal("fuel_collected", fuel_amount)
	$RigidBody2D/Sprite.frame = 1