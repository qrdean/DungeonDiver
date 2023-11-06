class_name ShopItem extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D

var texture: Texture = null

func _ready():
	if texture:
		sprite_2d.texture = texture

func set_sprite_texture(p_texture: Texture):
	texture = p_texture
