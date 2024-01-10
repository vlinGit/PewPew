extends CharacterBody2D

@onready var playerMesh = get_node("MeshInstance2D")
@export var SPEED = 300.0
@export var ACCEL = 0.5
@export var FRICTION = 0.1
@export var DSPEED = 20.0
@export var bullet: PackedScene
var canDash = true
var disabledTime = 0 # only use msec

func disableDash():
	playerMesh.modulate = Color(1,0,0)
	canDash = false
	disabledTime = Time.get_ticks_msec()

func dashCooldownAnimate():
	var elabsed = disabledTime - Time.get_ticks_msec()
	if elabsed % 200 == 0:
		playerMesh.modulate.g += 0.1
		playerMesh.modulate.b += 0.1

func shooter():
	var b = bullet.instantiate()
	b.connect("hit", _on_hit)
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

func _on_dash_cooldown_timeout():
	playerMesh.modulate = Color(1,1,1,1)
	canDash = true # Replace with function body.
	disabledTime = 0

func _on_hit():
	global.hits += 1

func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var dash = Input.is_action_just_pressed("dash")
	var shoot = Input.is_action_just_pressed("shoot")

	if get_last_slide_collision() and get_last_slide_collision().get_collider():
		if "wall" not in get_last_slide_collision().get_collider().name:
			global.gameOver = true
			get_tree().change_scene_to_file("res://gameOver.tscn")

	if shoot:
		shooter()

	if direction.length() > 0:
		var finalSpeed = SPEED
		if dash and canDash:
			disableDash()
			finalSpeed *= DSPEED
			$dashCooldown.start()
		velocity = velocity.lerp(direction.normalized() * finalSpeed, ACCEL)
	else:
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)

	if not canDash:
		dashCooldownAnimate()

	if !global.gameOver:
		move_and_slide()

