extends CharacterBody2D

const SPEED = 500.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Node2D = $Weapon

var last_direction: Vector2

func _ready():
	animated_sprite.play("default")

func _physics_process(_delta):
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 or direction.y != 0:
		last_direction = direction

	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	handle_anim(direction)
	handle_sword()
	move_and_slide()

func handle_anim(direction: Vector2):
	if direction.x > 0:
		animated_sprite.play("right-attack")
	if direction.y > 0:
		animated_sprite.play("down-attack")
	if direction.x < 0:
		animated_sprite.play("left-attack")
	if direction.y < 0:
		animated_sprite.play("up-attack")

	if direction.x == 0 and direction.y == 0:
		animated_sprite.play("default")

func handle_sword():
	if Input.is_action_just_pressed("attack"):
		weapon.active = true
		if last_direction.x > 0:
			weapon.position = Vector2(30, 0)
		if last_direction.y > 0:
			weapon.position = Vector2(0, 30)
		if last_direction.x < 0:
			weapon.position = Vector2(-30, 0)
		if last_direction.y < 0:
			weapon.position = Vector2(0, -30)
