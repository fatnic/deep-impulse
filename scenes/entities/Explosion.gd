extends Area2D

func _ready():
	pass
	
func _on_Area2D_body_entered(body):
	pass
#	var d = global_position + body.global_position
#	body.apply_impulse(Vector2(), d.normalized() * 100)