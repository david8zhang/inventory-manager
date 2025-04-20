class_name Item
extends Node2D

@export var item_stats: ItemStats
@onready var curr_sprite = $Sprite2D as Sprite2D

# Take into account rotation
var curr_item_height
var curr_item_width

func _ready():
	curr_item_height = item_stats.inventory_height
	curr_item_width = item_stats.inventory_width
	curr_sprite.texture = item_stats.texture
