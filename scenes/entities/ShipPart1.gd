extends RigidBody2D

var new_velocity = null

func _ready():
	pass
	
	
func _physics_process(delta):
	if new_velocity:
		linear_velocity = new_velocity
		new_velocity = null