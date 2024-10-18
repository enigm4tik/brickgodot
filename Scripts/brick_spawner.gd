extends Node

class_name BrickSpawner

const COLUMNS: int = 5
const ROWS: int = 6

@onready var ball: Ball = $"../Ball"
@onready var ui: UI = $"../UI"

@export var brick_scene: PackedScene
@export var margin: Vector2 = Vector2(8, 8)
@export var spawn_start: Marker2D

var brick_count: int = 0

func _ready() -> void:
	spawn_from_definition(LevelDefinitions.get_current_level())


func spawn_from_definition(level_definition: Array) -> void:
	var test_brick: Brick = brick_scene.instantiate()
	add_child(test_brick)
	var brick_size: Vector2 = test_brick.get_size()
	test_brick.queue_free()
	
	var rows: int = level_definition.size()
	var columns: int = level_definition[0].size()
	
	var row_width: float = brick_size.x * columns + margin.x * (columns -1)
	var spawn_position_x: float = (-row_width + brick_size.x + margin.x) / 2
	var spawn_position_y: float = spawn_start.position.y
	
	for i: int in rows: 
		for j: int in columns: 
			if level_definition[i][j] == 0:
				continue
			var brick: Brick = brick_scene.instantiate()
			add_child(brick)
			brick.set_initial_level(level_definition[i][j])
			var x: float = spawn_position_x + j * (margin.x + brick.get_size().x)
			var y: float = spawn_position_y + i * (margin.y + brick.get_size().y)
			brick.set_position(Vector2(x, y))
			brick.brick_destroyed.connect(on_brick_destroyed)
			brick_count += 1


func on_brick_destroyed(level: int) -> void:
	LevelDefinitions.current_points += level * 10
	ui.set_points()
	brick_count -= 1
	if brick_count == 0:
		ball.reset_ball()
		ui.on_level_won()
