extends CharacterBody2D

class_name Ball

signal life_lost

const VELOCITY_LIMIT: int = 40 

@export var ball_speed: int = 15
@export var death_zone: DeathZone
@export var ui: UI 

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var speed_multiplier: float = 1.05
var start_position: Vector2

func _ready() -> void:
	ui.set_lives(LevelDefinitions.current_lives)
	ui.set_level()
	ui.set_points()
	start_position = position
	death_zone.life_lost.connect(on_life_lost)


func _physics_process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(velocity * ball_speed * delta)
	
	if (!collision):
		return
		
	var collider: Object = collision.get_collider()
	if collider is Brick: 
		collider.decrease_level()
	
	if collider is Paddle:
		ball_collision(collider)
	else: 
		velocity = velocity.bounce(collision.get_normal())


func start_ball() -> void:
	position = start_position
	randomize()
	velocity = Vector2(randf_range(-1, 1), randf_range(-1, -1)).normalized() * ball_speed


func on_life_lost() -> void:
	LevelDefinitions.current_lives -= 1
	ui.set_lives(LevelDefinitions.current_lives)
	if LevelDefinitions.current_lives == 0:
		ui.game_over()
	else:
		life_lost.emit()
		reset_ball()


func reset_ball() -> void:
	position = start_position
	velocity = Vector2.ZERO


func ball_collision(collider: Paddle) -> void:
	var ball_center_x: float = position.x
	var collider_width: float = collider.get_width()
	var collider_center_x: float = collider.position.x
	var velocity_xy: float = velocity.length()
	var collision_x: float = (ball_center_x - collider_center_x) / (collider_width / 2)
	var new_velocity: Vector2 = Vector2.ZERO
	
	new_velocity.x = velocity_xy * collision_x
	new_velocity.y = sqrt(absf(velocity_xy * velocity_xy - new_velocity.x * new_velocity.x)) * (-1 if velocity.y > 0 else 1)
	
	velocity = (new_velocity * speed_multiplier).limit_length(VELOCITY_LIMIT)
