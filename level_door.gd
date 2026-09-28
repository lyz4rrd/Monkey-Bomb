extends Area2D

@export_file("*.tscn") var next_level: String

var unlocked: bool = false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if not unlocked:
		return

	get_tree().call_deferred("change_scene_to_file", next_level)
