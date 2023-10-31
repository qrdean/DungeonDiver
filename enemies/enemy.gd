class_name Enemy extends CharacterBody2D

@export var enemy_stats: BaseEnemyResource
@export var coin: PackedScene
@export var player: Player

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var health: int
var move_speed: float
var attack_speed: float
var knocked_back: bool = false

func _ready() -> void:
	navigation_agent.target_position = player.global_position
	if enemy_stats:
		health = enemy_stats.health
		move_speed = enemy_stats.move_speed
		attack_speed = enemy_stats.attack_speed

func _physics_process(_delta) -> void:
	navigation_agent.target_position = player.global_position

	if knocked_back: 
		velocity = lerp(velocity, Vector2.ZERO, 0.1)
		if (velocity.x < 0.01 and velocity.x > - 0.01) and (velocity.y < 0.01 and velocity.y > -0.01):
			knocked_back = false
	else:
		if navigation_agent and not navigation_agent.is_navigation_finished():
			var current_agent_position = global_position
			var next_path_position = navigation_agent.get_next_path_position()

			velocity = (next_path_position - current_agent_position).normalized() * enemy_stats.move_speed
		
	move_and_slide()

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
