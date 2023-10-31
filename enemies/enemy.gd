class_name Enemy extends CharacterBody2D

@export var enemy_stats: BaseEnemyResource
@export var coin: PackedScene

var health: int
var move_speed: float
var attack_speed: float
var knocked_back: bool = false

func _ready():
	if enemy_stats:
		health = enemy_stats.health
		move_speed = enemy_stats.move_speed
		attack_speed = enemy_stats.attack_speed

func _physics_process(_delta):
	if knocked_back: 
		velocity = lerp(velocity, Vector2.ZERO, 0.1)
		if velocity == Vector2.ZERO:
			knocked_back = false
	move_and_slide()

func take_damage(knockback_dir: Vector2):
	knocked_back = true
	velocity = knockback_dir
	health -= 1
	if health <= 0:
		_spawn_item()
		self.queue_free()

func _spawn_item():
	var coin_instance: Item = coin.instantiate() as Item
	coin_instance.resource = ItemResource.new(ItemResource.ItemType.COIN, enemy_stats.currency, ItemResource.PotionTypes.NONE)
	coin_instance.global_position = self.global_position
	add_sibling.call_deferred(coin_instance)
