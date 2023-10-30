class_name Player extends CharacterBody2D

const SPEED = 500.0

@export var player_stats: PlayerStats

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Node2D = $Weapon
@onready var pickup_area: Area2D = $PickupArea

var health: int
var mana: int

var last_direction: Vector2

func _ready():
	health = player_stats.max_health
	mana = player_stats.max_mana
	animated_sprite.play("default")
	pickup_area.item_pickup.connect(_handle_item_pickup)

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

func _handle_item_pickup(item: Item):
	var spent = false
	if item.resource.type == ItemResource.ItemType.WEAPON:
		print_debug("Got Weapon")
		player_stats.attack_damage += item.resource.stats
		spent = true
		print_debug(player_stats.attack_damage)
	if item.resource.type == ItemResource.ItemType.ARMOR:
		print_debug("Got Armor")
		player_stats.armor += item.resource.stats
		spent = true
		print_debug(player_stats.armor)
	if item.resource.type == ItemResource.ItemType.POTION:
		print_debug("Got Potion")
		if item.resource.potion_sub_type == ItemResource.PotionTypes.HEALTH:
			print_debug("health potion")
			health += item.resource.stats
			if health > player_stats.max_health:
				health = player_stats.max_health
				spent = true
			print_debug(health)
		if item.resource.potion_sub_type == ItemResource.PotionTypes.MANA:
			print_debug("mana potion")
			mana += item.resource.stats
			if mana > player_stats.max_mana:
				mana = player_stats.max_mana
				spent = true
			print_debug(mana)
	
	if spent:
		item.queue_free()
