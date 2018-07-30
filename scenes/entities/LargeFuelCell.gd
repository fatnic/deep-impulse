extends RigidBody2D

export (float) var amount = 100
var in_area = false
var collected = false

signal fuel_collected

func _ready():
	pass


func collected():
	collected = true
	emit_signal("fuel_collected", amount)
	$Sprite.frame = 1

func _on_Interaction_body_entered(body):
	if body.get_name() == "Engine" and collected == false:
		in_area = true
		collected()


func _on_Interaction_body_exited(body):
	in_area = false