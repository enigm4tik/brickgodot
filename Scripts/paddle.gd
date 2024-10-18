extends RigidBody2D

class_name Paddle

var direction = Vector2.ZERO
var camera_rect: Rect2
var half_paddle_width: float
var is_ball_started: bool = false

@export var speed: int = 400
@export var camera: Camera2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var ball: Ball = $"../Ball"

func _ready() -> void:
	ball.life_lost.connect(on_ball_lost)
	camera_rect = camera.get_viewport_rect()
	half_paddle_width = collision_shape_2d.shape.get_rect().size.x/2 * scale.x


func _process(_delta) -> void:
	var camera_start_x: float = camera.position.x - camera_rect.size.x/2
	var camera_end_x: float = camera_start_x + camera_rect.size.x
	
	if global_position.x - half_paddle_width < camera_start_x:
		global_position.x = camera_start_x + half_paddle_width
	elif global_position.x + half_paddle_width > camera_end_x:
		global_position.x = camera_end_x - half_paddle_width


func _physics_process(_delta: float) -> void:
	linear_velocity = speed * direction 


func _input(_event) -> void:
	if Input.is_action_pressed("left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("right"):
		direction = Vector2.RIGHT
	else:
		direction = Vector2.ZERO

	if direction != Vector2.ZERO and not is_ball_started:
		ball.start_ball()
		is_ball_started = true


func on_ball_lost() -> void:
	is_ball_started = false
	direction = Vector2.ZERO


func get_width() -> float:
	return collision_shape_2d.shape.get_rect().size.x
