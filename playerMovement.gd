extends CharacterBody2D

@export var SPEED = 300.0
@export var ACCEL = 0.5
@export var FRICTION = 0.1
@export var DSPEED = 20.0
@export var bullet: PackedScene
var canDash = true

func shooter():
	var b = bullet.instantiate()
	owner.add_child(b)
	b.transform = $Muzzle.global_transform

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	look_at(get_global_mouse_position())
	var direction = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var dash = Input.is_action_just_pressed("dash")
	var shoot = Input.is_action_just_pressed("shoot")
	
	if shoot:
		shooter()
	
	if direction.length() > 0:
		var finalSpeed = SPEED
		if dash and canDash:
			canDash = false
			finalSpeed *= DSPEED
			$dashCooldown.start()
		velocity = velocity.lerp(direction.normalized() * finalSpeed, ACCEL)
	else:
		velocity = velocity.lerp(Vector2.ZERO, FRICTION)
	

	move_and_slide()

func _on_dash_cooldown_timeout():
	canDash = true # Replace with function body.
