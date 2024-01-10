extends CharacterBody2D

@onready var player = get_tree().get_root().get_node("Node2D").get_node("Player")
@export var speed = 200.0
@export var accel = 0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity = velocity.lerp((player.position - global_position).normalized() * speed, accel)
	
	if !global.gameOver:
		move_and_slide()


