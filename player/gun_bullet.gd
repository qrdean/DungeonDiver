extends Area2D

@onready var visible_on_screen: VisibleOnScreenNotifier2D = $VisibleOnScreenNotifier2D

var direction = Vector2.RIGHT
var SPEED = 400

var knockback_power = 100.0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible_on_screen.screen_exited.connect(_free_me)
	self.body_entered.connect(_hit_register)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * SPEED * delta

func _hit_register(body: Node2D):
	if body is Enemy:
		var knockback_direction := Vector2(direction.x * knockback_power, direction.y * knockback_power)
		body.take_damage(knockback_direction)
		self.queue_free()

func _free_me():
	self.queue_free()
