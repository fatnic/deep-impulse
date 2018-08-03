extends RigidBody2D

func _ready():
	$Sprite.visible = false
	$CollisionShape2D.disabled = true
	mass = 0.01

