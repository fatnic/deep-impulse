extends "res://scenes/entities/interactables/base/Interactable.gd"

export (float) var fuel_amount = 20

signal fuel_collected

func _ready():
	pass

func entered(body):
	set_notification("I am the lizard queen")

func exited(body):
	pass

func interacting():
	not_interactive()
	emit_signal("fuel_collected", fuel_amount)
	$Sprite.frame = 1