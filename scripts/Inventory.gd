class_name Inventory
extends VBoxContainer

@export var inventory_box_scene: PackedScene

const MAX_ROWS = 8
const MAX_COLS = 8

var num_rows = 4
var num_cols = 4
var padding = 10
var inventory_box_size = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	var curr_x = 0
	var curr_y = 0
	
	for i in range(0, MAX_ROWS):
		var hbox_container = HBoxContainer.new()
		curr_x = 0
		for j in range(0, MAX_COLS):
			var inventory_box = inventory_box_scene.instantiate()
			hbox_container.add_child(inventory_box)
			inventory_box.global_position = Vector2(curr_x, curr_y)
			curr_x += inventory_box_size + padding
		add_child(hbox_container)
		hbox_container.alignment = BoxContainer.ALIGNMENT_CENTER
		curr_y += inventory_box_size + padding
