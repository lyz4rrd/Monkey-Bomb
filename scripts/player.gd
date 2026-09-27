extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -250.0

const BOOSTED_SPEED = 150.0
const BOOSTED_JUMP_VELOCITY = -350.0
const BOOST_DURATION = 5.0

var boost_time_remaining: float = 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var bomb = get_tree().get_first_node_in_group("bomb")
@onready var bomb_transfer_area: Area2D = $BombTransferArea

func _ready() -> void:
	bomb_transfer_area.body_entered.connect(_on_bomb_transfer_body_entered)
	
func _on_bomb_transfer_body_entered(body: Node2D) -> void:
	if not body.is_in_group("robot"):
		return

	var robot := body as CharacterBody2D

	if robot == null:
		return

	if not bomb.can_transfer():
		return

	if bomb.holder == self:
		bomb.set_holder(robot)

	elif bomb.holder == robot:
		bomb.set_holder(self)

func _physics_process(delta: float) -> void:
	# decrease boost timer if active
	if boost_time_remaining > 0.0:
		boost_time_remaining -= delta
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		if boost_time_remaining > 0.0:
			velocity.y = BOOSTED_JUMP_VELOCITY
		else:
			velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		if boost_time_remaining > 0.0:
			velocity.x = direction * BOOSTED_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		if boost_time_remaining > 0.0:
			velocity.x = move_toward(velocity.x, 0, BOOSTED_SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	# Face the direction of travel.
	if direction != 0:
		animated_sprite.flip_h = direction < 0

	# Pick an animation based on movement state.
	if not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	move_and_slide()
	
func activate_banana_boost() -> void:
	boost_time_remaining = BOOST_DURATION
