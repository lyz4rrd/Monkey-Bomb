extends Node2D

func _on_start_game_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://level1.tscn")
