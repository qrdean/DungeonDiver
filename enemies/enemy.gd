class_name Enemy extends CharacterBody2D

@export var enemy_stats: BaseEnemyResource
@export var coin: PackedScene
@export var player: Player

@onready var hitbox_area: Area2D = $hitbox
@onready var player_checker_area: Area2D = $player_checker
@onready var attack_timer: Timer = $attack_timer
@onready var position_change_timer: Timer = $position_change_timer

var health: int
var knocked_back: bool = false
var attacking: bool = false
var windup: bool = false
var randomnum: float
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	randomnum = rng.randf()
	if enemy_stats:
		health = enemy_stats.health

	position_change_timer.wait_time = enemy_stats.attack_speed
	player_checker_area.attack_player.connect(_attack)	
	attack_timer.timeout.connect(_stop_attack)
	position_change_timer.timeout.connect(_position_change)

func _physics_process(_delta) -> void:
	if attacking:
		move(player.global_position, _delta, 2.0)
	else:
		move(get_circle_position(randomnum), _delta)

func move(target, delta, modifier = 1.0):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * enemy_stats.move_speed * modifier
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()

func get_circle_position(random) -> Vector2:
	var kill_circle = player.global_position
	var radius = enemy_stats.radial_distance 
	var angle = random * PI * 2
	var x = kill_circle.x + cos(angle) * radius
	var y = kill_circle.y + sin(angle) * radius

	return Vector2(x, y)

func take_damage(knockback_dir: Vector2) -> void:
	knocked_back = true
	velocity = knockback_dir
	health -= 1
	if health <= 0:
		_spawn_item()
		self.queue_free()

func _spawn_item() -> void:
	var coin_instance: Item = coin.instantiate() as Item
	coin_instance.resource = ItemResource.new(ItemResource.ItemType.COIN, enemy_stats.currency, ItemResource.PotionTypes.NONE)
	coin_instance.global_position = self.global_position
	add_sibling.call_deferred(coin_instance)

func _attack():
	attacking = true
	attack_timer.start()

func _stop_attack():
	attacking = false

func _position_change():
	randomnum = rng.randf()
