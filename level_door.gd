extends Area2D

var unlocked: bool = false

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("player"):
		return

	if not unlocked:
		return

	print("PLAYER TOUCHED DOOR")
	get_tree().call_deferred("change_scene_to_file", "res://level2.tscn")
