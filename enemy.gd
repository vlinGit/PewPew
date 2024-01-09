extends CharacterBody2D

@onready var player = get_tree().get_root().get_node("Node2D").get_node("Player")
@export var speed = 200.0
@export var accel = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var curPos = get_canvas_transform().origin + global_position
	velocity = velocity.lerp((player.position - global_position).normalized() * speed, accel)

	move_and_slide()


