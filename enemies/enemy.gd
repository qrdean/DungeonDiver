class_name Enemy extends CharacterBody2D

@export var enemy_stats: BaseEnemyResource
@export var coin: PackedScene
@export var player: Player

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

@onready var hitbox_area: Area2D = $hitbox
@onready var player_checker_area: Area2D = $player_checker
@onready var attack_timer: Timer = $attack_timer

var health: int
var move_speed: float
var attack_speed: float
var knocked_back: bool = false

var player_target: Player
var attacking: bool = false
var windup: bool = false

var randomnum: float

func _ready() -> void:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	randomnum = rng.randf()
	navigation_agent.target_position = player.global_position
	if enemy_stats:
		health = enemy_stats.health
		move_speed = enemy_stats.move_speed
		attack_speed = enemy_stats.attack_speed
	player_checker_area.attack_player.connect(_attack)	
	attack_timer.timeout.connect(_stop_attack)

func _physics_process(_delta) -> void:
	if attacking:
		move(player.global_position, _delta)
	else:
		move(get_circle_position(randomnum), _delta)

func move(target, delta):
	var direction = (target - global_position).normalized()
	var desired_velocity = direction * enemy_stats.move_speed
	var steering = (desired_velocity - velocity) * delta * 2.5
	velocity += steering
	move_and_slide()

func get_circle_position(random) -> Vector2:
	var kill_circle = player.global_position
	var radius = 100
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
