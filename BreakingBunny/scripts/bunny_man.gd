extends CharacterBody2D


const SPEED = 1000.0
const JUMP_VELOCITY = -55000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor() and collision_mask != 1:
		velocity.y += JUMP_VELOCITY * delta
		match collision_mask:
			2:
				await get_tree().create_timer(0.1).timeout
				collision_mask = 1
				$SwitchLaneSound.play()
			4:
				await get_tree().create_timer(0.1).timeout
				collision_mask = 2
				$SwitchLaneSound.play()
	
	if Input.is_action_just_pressed("down") and is_on_floor():
		match collision_mask:
			1:
				collision_mask = 2
				$SwitchLaneSound.play()
			2:
				collision_mask = 4
				$SwitchLaneSound.play()


	move_and_slide()
