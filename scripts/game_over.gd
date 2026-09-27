extends Node2D

func _ready() -> void:
	$CenterContainer/VBoxContainer/PlayAgainButton.grab_focus()

func _on_play_again_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://level1.tscn")


func _on_exit_game_button_pressed() -> void:
	GameManager.reset_game()
	get_tree().change_scene_to_file("res://intro.tscn")
