class_name Inventory
extends VBoxContainer

@export var inventory_box_scene: PackedScene
@onready var game = get_node("/root/Main") as Game
var top_left = Vector2(0, 0)
var inventory_panel_grid

const MAX_ROWS = 8
const MAX_COLS = 8

var num_rows = 4
var num_cols = 4
var padding = 5
var inventory_box_size = 50

func _ready():
	inventory_panel_grid = []
	var first_box
	for i in range(0, num_rows):
		inventory_panel_grid.append([])
		var hbox_container = HBoxContainer.new()
		for j in range(0, num_cols):
			var inventory_box = inventory_box_scene.instantiate() as InventoryBox
			hbox_container.add_child(inventory_box)
			hbox_container.add_theme_constant_override("separation", 5)
			if i == 0 and j == 0:
				first_box = inventory_box
			inventory_panel_grid[i].append(inventory_box)
		add_child(hbox_container)
		hbox_container.alignment = BoxContainer.ALIGNMENT_CENTER
	assert(first_box != null, "invalid initial inventory box!")
	await get_tree().process_frame
	top_left = first_box.get_global_transform().origin

func _process(_delta):
	var camera = game.camera as Camera2D
	var mouse_pos = camera.get_global_mouse_position()
	var board_pos = convert_world_pos_to_board_pos(mouse_pos)
	if game.curr_selected_item != null:
		preview_item_placement(game.curr_selected_item, board_pos)

func convert_world_pos_to_board_pos(world_pos: Vector2):
	var board_col = floor((world_pos.x - top_left.x) / (inventory_box_size + padding))
	var board_row = floor((world_pos.y - top_left.y) / (inventory_box_size + padding))
	if board_row >= 0 and board_row < num_rows and board_col >= 0 and board_col < num_cols:
		return Vector2(board_row, board_col)
	return Vector2(-1, -1)

func preview_item_placement(item: Item, board_pos: Vector2):
	var curr_item_width = item.curr_item_width
	var curr_item_height = item.curr_item_height

	# Fetch item mid point
	var item_mid_width = floor(curr_item_width / 2)
	var item_mid_height = floor(curr_item_height / 2)

	# Fetch num rows above, below and cols left, right of midpoint to keep preview in bounds of grid
	var rows_above = max(1, item_mid_height)
	var rows_below = (curr_item_height - 1) - item_mid_height
	var cols_left = max(1, item_mid_width)
	var cols_right = (curr_item_width - 1) - item_mid_width
	var clamped_row = clamp(board_pos.x, rows_above - 1, num_rows - 1 - rows_below)
	var clamped_col = clamp(board_pos.y, cols_left - 1, num_cols - 1 - cols_right)

	# var log_line = "clamped_row: %s, clamped_col: %s, rows_above: %s, rows_below: %s, cols_left: %s, cols_right %s"
	# print(log_line % [clamped_row, clamped_col, rows_above, rows_below, cols_left, cols_right])

	# Preview item by darkening panels
	for i in range(clamped_row - rows_above, clamped_row + rows_below):
		for j in range(clamped_col - cols_left, clamped_col + cols_right):
			print("i: %s, j: %s" % [i, j])
			var inventory_box = inventory_panel_grid[i][j]

			var stylebox_panel = inventory_box.get_theme_stylebox("panel").duplicate()
			stylebox_panel.bg_color = Color(0, 0, 0, 0.75)

			inventory_box.add_theme_stylebox_override("panel", stylebox_panel)
