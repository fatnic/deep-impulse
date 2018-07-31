extends Node2D

export (int) var thrust = 22
export (int) var max_thrust = 100
export (float) var turn_speed = 1.5

export (int) var max_fuel = 100
export (int) var fuel = 100
export (float) var fuel_per_second = 5

export (int) var max_structural = 100
export (int) var structural = 100

signal fuel_changed
signal structural_changed

onready var exploded = preload("res://scenes/entities/ExplodedPlayer.tscn")


func _ready():
	emit_signal("fuel_changed", fuel * 100 / max_fuel)


func rotate_ship(direction):
	if fuel <= 0: return
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
		
	if Input.is_action_just_pressed("explode"):
		explode()
		
	check_collision()
		
	
		
func thrust(force):

	if fuel < 0: fuel = 0

	if fuel == 0:
		$ThrustSound.stop()
		$Engine/Flames.emitting = false
		structural = 0
		emit_signal("structural_changed", structural * 100 / max_structural) 
		explode()
		return

	if fuel > 0:
		$Engine.apply_impulse(Vector2(), Vector2(0, -force).rotated($Engine.rotation))
		fuel -= fuel_per_second * get_process_delta_time()
		emit_signal("fuel_changed", fuel * 100 / max_fuel)
		if $ThrustSound.playing == false: $ThrustSound.play()
		$Engine/Flames.emitting = true
	
	
func fuel_collected(amount):
	var new_fuel = fuel + amount
	fuel = min(new_fuel, max_fuel)
	emit_signal("fuel_changed", fuel * 100 / max_fuel)


func check_collision():
	
	if structural < 0:
		explode()
		
	#TODO: Fix this shitty system
	var del = $Engine.linear_velocity.length()
	if del > 15:
		var cols = $Engine.get_colliding_bodies()
		if cols:
			structural -= (del * 2) * get_process_delta_time()
			emit_signal("structural_changed", structural * 100 / max_structural) 
		
		
func explode():
	breakup(null)
	
			
func breakup(origin):

	var xp = exploded.instance()
	xp.position = $Engine.global_position
	xp.rotation = $Engine.global_rotation
	var vel = $Engine.linear_velocity
	
	$Engine/CollisionShape2D.disabled = true
	queue_free()
	get_tree().get_root().add_child(xp)
	
	var parts = get_tree().get_nodes_in_group("exploded_player")
	for p in parts:
		p.linear_velocity = vel
	
#	var expl = load("res://scenes/entities/Explosion.tscn").instance()
#	expl.position = xp.global_position - Vector2(0, -5).rotated(xp.rotation)
#	get_tree().get_root().add_child(expl)
	
	
