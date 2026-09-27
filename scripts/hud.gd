extends CanvasLayer

@onready var bomb = get_tree().get_first_node_in_group("bomb")
@onready var bomb_timer_label: Label = $BombTimerLabel
@onready var lives_label: Label = $LivesLabel
@onready var banana_timer_label: Label = $BananaBoostLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	lives_label.text = "LIVES: " + str(GameManager.lives)
	
	var player = get_tree().get_first_node_in_group("player")

	if player != null:
		if player.boost_time_remaining > 0.0:
			banana_timer_label.visible = true
			banana_timer_label.text = "BOOST: " + str(ceil(player.boost_time_remaining))
		else:
			banana_timer_label.visible = false
	
	if bomb == null:
		return

	bomb_timer_label.text = "TIME: " + str(ceil(bomb.time_remaining))
