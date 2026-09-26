extends Area2D

@export var player_holder_offset: Vector2 = Vector2(0, -18)
@export var robot_holder_offset: Vector2 = Vector2(0, -8)
@export var transfer_cooldown: float = 0.7

@export var bomb_duration: float = 15.0
var time_remaining: float

var holder: CharacterBody2D
var cooldown_remaining: float = 0.0

func _ready() -> void:
	time_remaining = bomb_duration

func _physics_process(delta: float) -> void:
	if cooldown_remaining > 0.0:
		cooldown_remaining -= delta
	if time_remaining > 0.0:
		time_remaining -= delta

func set_holder(new_holder: CharacterBody2D) -> void:
	holder = new_holder
	cooldown_remaining = transfer_cooldown
	call_deferred("_attach_to_holder")


func can_transfer() -> bool:
	return cooldown_remaining <= 0.0

func _attach_to_holder() -> void:
	if holder == null:
		return

	reparent(holder)
	if holder.is_in_group("player"):
		position = player_holder_offset
	elif holder.is_in_group("robot"):
		position = robot_holder_offset
