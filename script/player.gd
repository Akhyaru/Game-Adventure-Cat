extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var on_ice = false

@onready var animated_sprite = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()
		
	if Input.is_action_just_pressed("quit"):
		get_tree().change_scene_to_file("res://scenes/difficulty.tscn")

	#get the input direction: -1, 0, 1
	var direction = Input.get_axis("move_left", "move_right")
	
	#flip the sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
	var friction = 3000 if on_ice else 300
	
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	# Check if standing on ice
	on_ice = true
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_normal().dot(Vector2.UP) > 0.9:
			if collision and collision.get_collider().is_in_group("ice"):
				on_ice = false # lower friction (slippery)
				break
	
	move_and_slide()
