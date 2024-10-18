extends RigidBody2D

class_name Brick

signal brick_destroyed(initial_level)

var level: int = 1 
var initial_level: int = 1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var sprites: Array[Texture2D] = [
	preload("res://Assets/brick_blue.png"),
	preload("res://Assets/brick_green.png"),
	preload("res://Assets/brick_grey.png"),
	preload("res://Assets/brick_orange.png"),
	preload("res://Assets/brick_red.png"),
	preload("res://Assets/brick_yellow.png"),
]

func get_size() -> Vector2:
	return collision_shape_2d.shape.get_rect().size


func set_initial_level(i_level: int) -> void:
	set_level(i_level)
	initial_level = i_level


func set_level(new_level: int) -> void:
	level = new_level
	sprite_2d.texture = sprites[new_level-1]


func decrease_level() -> void:
	if level > 1: 
		set_level(level -1)
	else:
		fade_out()
		
func fade_out() -> void:
	collision_shape_2d.disabled = true
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(destroy)
	
func destroy() -> void:
	queue_free()
	brick_destroyed.emit(initial_level)
	
func get_width() -> float:
	return get_size().x
