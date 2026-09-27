extends Area2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	animated_sprite.play("default")

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	body.activate_banana_boost()
	queue_free()
