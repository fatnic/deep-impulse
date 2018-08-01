extends Area2D

export (bool) var interactable = true
export (bool) var collectable = true
export (float) var interact_range = 10

var in_range = false
var interacting = false

signal set_notification


func _ready():
	$CollisionShape2D.shape.radius = interact_range


func _physics_process(delta):

	if interactable:
		if in_range and Input.is_action_pressed("interact"):
			interacting = true
			interacting()

	if interacting == true and Input.is_action_just_released("interact"):
		interacting = false


func _on_Interactable_body_entered(body):
	if body.get_name() == "Engine":
		in_range = true
		
		if collectable:	
			set_notification("Press 'K' to collect")
			
		entered(body)


func _on_Interactable_body_exited(body):
	set_notification("")
	in_range = false
	exited(body)


func not_interactive():
	set_notification("")
	interactable = false
	$CollisionShape2D.disabled = true
	
func set_notification(message):
	emit_signal("set_notification", message)