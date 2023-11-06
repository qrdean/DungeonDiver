class_name Player extends CharacterBody2D

const SPEED = 500.0

@export var player_stats: PlayerStats

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var weapon: Node2D = $Weapon
@onready var gun: Node2D = $Gun
@onready var pickup_area: Area2D = $PickupArea


var weapon_inventory: Array[WeaponResource] = []
var armor_inventory: Array[ItemResource] = []
var consumable_inventory: Array[ItemResource] = []
var currency: int = 0

# TODO: wrap this in some kind of structure
var current_weapon: WeaponResource = null
var current_weapon_index: int = 0

var health: int
var mana: int
var cant_move: bool = false 

var last_direction: Vector2 = Vector2(0.0, 1.0)

func _ready() -> void:
	health = player_stats.max_health
	mana = player_stats.max_mana
	if current_weapon:
		gun.set_stats(current_weapon)

	animated_sprite.play("default")
	pickup_area.item_pickup.connect(_handle_item_pickup)
	weapon.animation_player.animation_finished.connect(_on_sword_timeout)

func _physics_process(_delta) -> void:
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 or direction.y != 0:
		last_direction = direction

	if direction:
			velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	if cant_move:
		velocity = Vector2.ZERO

	handle_walk_anim(direction)
	# handle_sword()
	gun_swap()
	shoot_gun()
	move_and_slide()

func handle_walk_anim(direction: Vector2) -> void:
	if direction.x > 0:
		animated_sprite.play("right-move")
	if direction.y > 0:
		animated_sprite.play("down-move")
	if direction.x < 0:
		animated_sprite.play("left-move")
	if direction.y < 0:
		animated_sprite.play("up-move")

	if direction.x == 0 and direction.y == 0:
		animated_sprite.play("default")

func shoot_gun() -> void:
	if Input.is_action_just_pressed("attack"):
		gun.shoot()

func gun_swap() -> void:
	if Input.is_action_just_pressed("prev_weapon"):
		print_debug("prev weapon")
		prev_weapon()
		return
	if Input.is_action_just_pressed("next_weapon"):
		print_debug("next weapon")
		next_weapon()
		return

func handle_sword() -> void:
	if Input.is_action_just_pressed("attack"):
		var direction = "down"
		if last_direction.x > 0:
			direction = "right"
			weapon.position = Vector2(30, 0)
		if last_direction.y > 0:
			direction = "down"
			weapon.position = Vector2(0, 30)
		if last_direction.x < 0:
			direction = "left"
			weapon.position = Vector2(-30, 0)
		if last_direction.y < 0:
			direction = "up"
			weapon.position = Vector2(0, -30)
		weapon.set_direction(direction)
		cant_move = true
		weapon.swing()

func next_weapon():
	if weapon_inventory.size() > 0:
		current_weapon_index += 1
		if current_weapon_index >= weapon_inventory.size():
			current_weapon_index = 0

		current_weapon = weapon_inventory[current_weapon_index]
		set_gun(current_weapon)

func prev_weapon():
	if weapon_inventory.size() > 0:
		current_weapon_index -= 1
		if current_weapon_index <= -1:
			current_weapon_index = weapon_inventory.size() - 1

		current_weapon = weapon_inventory[current_weapon_index]
		set_gun(current_weapon)

func set_gun(weapon_stats: WeaponResource):
	gun.set_stats(weapon_stats)

func _handle_item_pickup(item: Item) -> void:
	print_debug(item)
	var spent = false
	if item.resource.type == ItemResource.ItemType.WEAPON:
		print_debug("Got Weapon")
		weapon_inventory.append(item.resource)
		if !current_weapon:
			current_weapon = item.resource 
			gun.set_stats(current_weapon)
		# player_stats.attack_damage += item.resource.stats
		spent = true
		_print_weapon_list(weapon_inventory)
	if item.resource.type == ItemResource.ItemType.ARMOR:
		print_debug("Got Armor")
		# player_stats.armor += item.resource.stats
		armor_inventory.append(item.resource)
		spent = true
		_print_resource_list(armor_inventory)
		# print_debug(player_stats.armor)
	if item.resource.type == ItemResource.ItemType.POTION:
		print_debug("Got Potion")
		consumable_inventory.append(item.resource)
		spent = true
		_print_resource_list(consumable_inventory)

	if item.resource.type == ItemResource.ItemType.COIN:
		print_debug("Got Coin")
		currency += item.resource.stats
		print_debug(currency)
		spent = true
	
	if spent:
		item.queue_free()


func _print_weapon_list(list: Array[WeaponResource])->void:
	for res in list:
		print_debug(res)
		print_debug(res.weapon_type)
		print_debug(res.attack_speed)

func _print_resource_list(list: Array[ItemResource]) -> void:
	for res in list:
		print_debug(res.type)
		print_debug(res.stats)
		print_debug(res.potion_sub_type)

func _on_sword_timeout() -> void:
	print_debug("in player script")
	cant_move = false
