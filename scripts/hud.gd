extends CanvasLayer

@onready var bomb = get_tree().get_first_node_in_group("bomb")
@onready var bomb_timer_label: Label = $BombTimerLabel
@onready var lives_label: Label = $LivesLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lives_label.text = "LIVES: " + str(GameManager.lives)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if bomb == null:
		return

	bomb_timer_label.text = "TIME: " + str(ceil(bomb.time_remaining))
