extends CanvasLayer


@onready var player: Player = get_parent()


func _process(_delta: float) -> void:
	$Panel/Panel/HealthBar.max_value = player.MAX_HEALTH
	$Panel/Panel/HealthBar.value = player.health
	$Panel/Panel/StaminaBar.max_value = player.max_stamina
	$Panel/Panel/StaminaBar.value = player.stamina
