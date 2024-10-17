extends RigidBody2D

class_name Brick

signal brick_destroyed(initial_level)

var level = 1 
var initial_level = 1

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

func get_size():
	return collision_shape_2d.shape.get_rect().size 	
	
func set_initial_level(level: int):
	set_level(level)
	initial_level = level

func set_level(new_level: int):
	level = new_level
	sprite_2d.texture = sprites[new_level-1]

func decrease_level():
	if level > 1: 
		set_level(level -1)
	else:
		fade_out()
		
func fade_out():
	collision_shape_2d.disabled = true
	var tween = get_tree().create_tween()
	tween.tween_property(sprite_2d, "modulate", Color.TRANSPARENT, .5)
	tween.tween_callback(destroy)
	
func destroy():
	queue_free()
	brick_destroyed.emit(initial_level)
	
func get_width():
	return get_size().x
