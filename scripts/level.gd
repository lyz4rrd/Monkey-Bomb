extends Node2D

@onready var bomb = $Bomb
@onready var robot = $Robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb.set_holder(robot)
