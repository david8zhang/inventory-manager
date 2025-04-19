class_name Inventory
extends VBoxContainer

@export var inventory_box_scene: PackedScene
@onready var game = get_node("/root/Main") as Game
var top_left = Vector2(0, 0)

const MAX_ROWS = 8
const MAX_COLS = 8

var num_rows = 4
var num_cols = 4
var padding = 5
var inventory_box_size = 50

func _ready():
	var first_box
	for i in range(0, num_rows):
		var hbox_container = HBoxContainer.new()
		for j in range(0, num_cols):
			var inventory_box = inventory_box_scene.instantiate() as InventoryBox
			hbox_container.add_child(inventory_box)
			hbox_container.add_theme_constant_override("separation", 5)
			if i == 0 and j == 0:
				first_box = inventory_box
		add_child(hbox_container)
		hbox_container.alignment = BoxContainer.ALIGNMENT_CENTER
	assert(first_box != null, "invalid initial inventory box!")
	await get_tree().process_frame
	top_left = first_box.get_global_transform().origin

func _process(_delta):
	var camera = game.camera as Camera2D
	var mouse_pos = camera.get_global_mouse_position()
	var board_pos = convert_world_pos_to_board_pos(mouse_pos)
	print(board_pos)

func convert_world_pos_to_board_pos(world_pos: Vector2):
	var board_col = floor((world_pos.x - top_left.x) / (inventory_box_size + padding))
	var board_row = floor((world_pos.y - top_left.y) / (inventory_box_size + padding))
	if board_row >= 0 and board_row < num_rows and board_col >= 0 and board_col < num_cols:
		return Vector2(board_row, board_col)
	return Vector2(-1, -1)
