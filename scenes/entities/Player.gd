extends Node2D

export (int) var thrust = 22
export (int) var max_thrust = 100
export (float) var turn_speed = 1.5

func _ready():
	pass


func rotate_ship(direction):
	$Engine.angular_velocity = direction * turn_speed
	
	
func _physics_process(delta):
	
	if Input.is_action_pressed("turn_left"):
		rotate_ship(-1)
		
	if Input.is_action_pressed("turn_right"):
		rotate_ship(1)
		
	if Input.is_action_pressed("thrust"):
		thrust(thrust)
		
	if Input.is_action_just_released("thrust"):
		$ThrustSound.stop()
		$Engine/Flames.emitting = false
		
		
func thrust(force):
	$Engine.apply_impulse(Vector2(), Vector2(0, -force).rotated($Engine.rotation))
	if $ThrustSound.playing == false:
		$ThrustSound.play()
	$Engine/Flames.emitting = true