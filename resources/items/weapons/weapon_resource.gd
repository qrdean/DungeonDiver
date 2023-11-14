class_name WeaponResource extends ItemResource

enum WeaponType {
	MELEE,
	RANGED
}

@export var weapon_type: WeaponType
@export var attack_speed: float
@export var bullet_scene: PackedScene
@export var bullet_resource: BulletResource

func _init(p_weapon_type = WeaponType.RANGED, p_attack_speed = 10.0, p_bullet_scene = null, p_bullet_resource = null):
	type = ItemType.WEAPON
	weapon_type = p_weapon_type
	attack_speed = p_attack_speed
	bullet_scene = p_bullet_scene
	bullet_resource = p_bullet_resource

enum WeaponsList {
	PISTOL,
  LONG_GUN 
}

static var weapon_resource_path_dictionary: Dictionary = {
	WeaponsList.PISTOL: "res://resources/items/weapons/pistol.tres",
	WeaponsList.LONG_GUN: "res://resources/items/weapons/long_gun.tres"
}

static func get_weapon_resource_path_dictionary() -> Dictionary:
	return weapon_resource_path_dictionary

static func get_pistol_resource() -> WeaponResource:
	return load(weapon_resource_path_dictionary[WeaponsList.PISTOL]) as WeaponResource

static func get_long_gun_resource() -> WeaponResource:
	return load(weapon_resource_path_dictionary[WeaponsList.LONG_GUN]) as WeaponResource
