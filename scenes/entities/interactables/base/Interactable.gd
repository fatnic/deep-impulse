extends Area2D

export (bool) var interactable = true
export (float) var interact_range = 10

var in_range = false
var interacting = false

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
	in_range = true
	entered(body)


func _on_Interactable_body_exited(body):
	in_range = false
	exited(body)
	
	
func not_interactive():
	interactable = false
	$CollisionShape2D.disabled = true