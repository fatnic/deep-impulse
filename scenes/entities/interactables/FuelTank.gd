extends "res://scenes/entities/interactables/base/Interactable.gd"

signal upgrade_collected

func _ready():
	pass


func entered(body):
	pass


func exited(body):
	pass


func interacting():
	not_interactive()
	emit_signal("upgrade_collected", "fit_fueltank")
	queue_free()