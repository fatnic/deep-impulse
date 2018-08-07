extends Node2D

export (int) var thrust = 22
export (int) var max_thrust = 100
export (float) var turn_speed = 1.5

export (int) var max_fuel = 100
export (int) var fuel = 100
export (float) var fuel_per_second = 5

export (int) var max_structural = 100
export (int) var structural = 100

var fuel_tank_fitted = false
var shielding_fitted = false

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
		
	if Input.is_action_just_pressed("jettison"):
		jettison_fueltank()
		
	if Input.is_action_just_pressed("jet_shields"):
		jettison_shields()
		
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


func scrap_collected(amount):
	var new_structural = structural + amount
	structural = min(new_structural, max_structural)
	emit_signal("structural_changed", structural * 100 / max_structural) 
	

func check_collision():
	
	if structural < 0:
		pass
#		explode()
		
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
		
	var camera = $Engine/PlayerCam
	$Engine.remove_child(camera)
	xp.get_node("ShipPart1").add_child(camera)
	
#	var expl = load("res://scenes/entities/Explosion.tscn").instance()
#	expl.position = xp.global_position - Vector2(0, -5).rotated(xp.rotation)
#	get_tree().get_root().add_child(expl)
	
func upgrade_collected(upgrade):
	print(upgrade)
	call(upgrade)

	
func fit_fueltank():
	fuel_tank_fitted = true
	$FuelTank/Sprite.visible = true
	$FuelTank/CollisionShape2D.disabled = false
	$FuelTank.mass = 2
	thrust += 10
	
func fit_shielding():
	shielding_fitted = true
	$ShieldLeft/Sprite.visible = true
	$ShieldRight/Sprite.visible = true
	$ShieldLeft/CollisionShape2D.disabled = false
	$ShieldRight/CollisionShape2D.disabled = false
	$ShieldLeft.mass = 2
	$ShieldRight.mass = 2
	thrust += 5
	
	
func jettison_fueltank():
	if fuel_tank_fitted:
		fuel_tank_fitted = false
		$FuelTankJoint.free()
		$FuelTank.apply_impulse(Vector2(5, 0), Vector2(0, -120).rotated($FuelTank.rotation))
		
func jettison_shields():
	$ShieldLeftJoint.free()
	$ShieldLeft.apply_impulse(Vector2(2, 0), Vector2(-100, 0).rotated($FuelTank.rotation))
	$ShieldRightJoint.free()
	$ShieldRight.apply_impulse(Vector2(2, 0), Vector2(100, 0).rotated($FuelTank.rotation))
	$Timer.start()


func _on_Timer_timeout():
	$ShieldFade.play("fadeout")	

func _on_ShieldFade_animation_finished(anim_name):
	$ShieldRight.queue_free()
	$ShieldLeft.queue_free()