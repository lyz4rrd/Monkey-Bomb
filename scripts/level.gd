extends Node2D

@onready var bomb = $Bomb
@onready var robot = $Robot

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bomb.set_holder(robot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_level_door_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("PLAYER REACHED DOOR")
