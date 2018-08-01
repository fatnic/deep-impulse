extends "res://scenes/entities/interactables/base/Interactable.gd"

export (float) var scrap_amount = 25

signal scrap_collected

func _ready():
	pass

func entered(body):
	pass

func exited(body):
	pass

func interacting():
	not_interactive()
	emit_signal("scrap_collected", scrap_amount)
	queue_free()