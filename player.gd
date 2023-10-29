extends CharacterBody2D

const SPEED = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(_delta):
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
