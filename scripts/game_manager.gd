extends Node

var lives: int = 3

func lose_life() -> bool:
	lives -= 1
	if lives <= 0:
		return true
	return false
	
func reset_game() -> void:
	lives = 3
