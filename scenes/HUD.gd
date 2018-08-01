extends CanvasLayer

func update_fuelbar(value):
	$FuelProgress.value = value
	
func update_structural(value):
	$StructuralProgress.value = value
	
func set_notification(message):
	$Notification.text = message