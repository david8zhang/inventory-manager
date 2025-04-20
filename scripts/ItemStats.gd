class_name ItemStats
extends Resource

enum ItemType {
	WEAPON,
	SHIELD,
	HELMET,
	CHEST_PLATE,
	LEG_PLATE,
	POTION,
	QUEST
}

@export var inventory_width := 0
@export var inventory_height := 0
@export var item_type: ItemType
@export var texture: Texture2D