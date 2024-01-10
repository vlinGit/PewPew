extends CanvasLayer

@onready var score: TextEdit = get_node("score")

# Called when the node enters the scene tree for the first time.
func _ready():
	score.text = "Score: " + str(global.hits)
