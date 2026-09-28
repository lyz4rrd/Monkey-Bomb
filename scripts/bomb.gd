extends Area2D

@export var player_holder_offset: Vector2 = Vector2(0, -18)
@export var robot_holder_offset: Vector2 = Vector2(0, -8)
@export var transfer_cooldown: float = 0.7

@export var bomb_duration: float = 15.0
var time_remaining: float

var exploded: bool = false

@onready var explosion = get_tree().current_scene.get_node("Explosion")
@onready var explosion_sprite = explosion.get_node("AnimatedSprite2D")

var holder: CharacterBody2D
var cooldown_remaining: float = 0.0

func _ready() -> void:
	time_remaining = bomb_duration
	explosion.hide()

func _physics_process(delta: float) -> void:
	if cooldown_remaining > 0.0:
		cooldown_remaining -= delta
	if time_remaining > 0.0:
		time_remaining -= delta
		if time_remaining <= 0.0:
			time_remaining = 0.0
			explode()

func set_holder(new_holder: CharacterBody2D) -> void:
	holder = new_holder
	cooldown_remaining = transfer_cooldown
	call_deferred("_attach_to_holder")


func can_transfer() -> bool:
	return cooldown_remaining <= 0.0 and not exploded

func _attach_to_holder() -> void:
	if holder == null:
		return

	reparent(holder)
	if holder.is_in_group("player"):
		position = player_holder_offset
	elif holder.is_in_group("robot"):
		position = robot_holder_offset

func explode() -> void:
	if exploded:
		return

	exploded = true
	
	var door = get_tree().current_scene.get_node("LevelDoor")
	door.unlocked = true

	if holder == null:
		return

	# Remember who had the bomb
	var bomb_holder = holder
	var player_died = bomb_holder.is_in_group("player")

	# Put explosion at holder's position
	explosion.global_position = bomb_holder.global_position

	# Show and play explosion
	explosion.show()
	explosion_sprite.show()
	explosion_sprite.frame = 0
	explosion_sprite.play("explode")

	# Hide the holder instead of deleting them immediately.
	# This keeps the Bomb alive while the explosion plays.
	bomb_holder.hide()

	# Calculate how long the animation takes
	var frame_count = explosion_sprite.sprite_frames.get_frame_count("explode")
	var animation_speed = explosion_sprite.sprite_frames.get_animation_speed("explode")
	var animation_length = frame_count / animation_speed

	# Wait for the explosion animation
	await get_tree().create_timer(animation_length).timeout


	# Hide the explosion
	explosion_sprite.stop()
	explosion_sprite.hide()
	explosion.hide()

	# Now remove the holder
	bomb_holder.queue_free()

	# Reset if the player died + dec life
	if player_died:
		var game_over = GameManager.lose_life()
		
		if game_over:
			get_tree().change_scene_to_file("res://game_over.tscn")
		else:
			get_tree().reload_current_scene()
