class_name Game
extends Node2D

@export var item_scene: PackedScene
@onready var mob = $Mob as Mob
@onready var hero = $Hero as Hero
@onready var camera = $Camera2D as Camera2D

# =================== PLACEHOLDER FOR TESTING ONLY ===================
@onready var spawn_weapon_btn = $CanvasLayer/SpawnWeapon as Button

var curr_selected_item: Item

func _ready():
	spawn_weapon_btn.pressed.connect(spawn_weapon)


func _process(_delta):
	var mouse_pos = camera.get_global_mouse_position()
	if curr_selected_item != null:
		curr_selected_item.global_position = Vector2(mouse_pos.x, mouse_pos.y)

func spawn_weapon():
	curr_selected_item = item_scene.instantiate() as Item
	curr_selected_item.item_stats = load("res://resources/weapons/ShortSword.tres") as WeaponStats
	add_child(curr_selected_item)
