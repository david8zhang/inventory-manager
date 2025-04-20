class_name WeaponStats
extends ItemStats

@export var damage := 0
@export var durability := 0

func _init():
	item_type = ItemType.WEAPON