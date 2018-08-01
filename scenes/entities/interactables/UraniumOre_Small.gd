extends "res://scenes/entities/interactables/base/Interactable.gd"

export (float) var fuel_amount = 10

signal fuel_collected

func _ready():
	pass

func entered(body):
	pass

func exited(body):
	pass

func interacting():
	not_interactive()
	emit_signal("fuel_collected", fuel_amount)
	queue_free()