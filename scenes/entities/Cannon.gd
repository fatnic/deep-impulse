extends StaticBody2D

export (int) var turret_speed = 2

var target = null
var line_of_sight = false

func _ready():
	pass
	

func _process(delta):
	if target:
		line_of_sight = false
		var space_state = get_world_2d().direct_space_state
		var result = space_state.intersect_ray(global_position, target.global_position, [self])
		if result:
			if result.collider.is_in_group("player"):
				line_of_sight = true
			
	if target and line_of_sight:
		var target_direction = (target.global_position - global_position).normalized()
		var current_direction = Vector2(1, 0).rotated($Turret.global_rotation)
		$Turret.global_rotation = current_direction.linear_interpolate(target_direction, turret_speed * delta).angle()
		

func _on_Area2D_body_entered(body):
	if body.get_name() == "Engine":
		target = body

func _on_Area2D_body_exited(body):
	if body == target:
		target = null