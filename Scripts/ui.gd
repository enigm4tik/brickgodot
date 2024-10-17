extends CanvasLayer

class_name UI

@onready var lives_label: Label = %LivesLabel
@onready var game_over_container: CenterContainer = %GameOverContainer
@onready var level_up_container: CenterContainer = %LevelUpContainer
@onready var game_won_container: CenterContainer = %GameWonContainer
@onready var points_label: Label = %PointsLabel
@onready var level_label: Label = %LevelLabel


func set_lives(lives: int):
	lives_label.text = "Lives: %d" % lives
	

func set_level():
	level_label.text = "LEVEL %d" % LevelDefinitions.current_level	
	

func set_points():
	points_label.text = "Points: %d" % LevelDefinitions.current_points


func game_over(): 
	game_over_container.show()


func _on_restart_button_pressed() -> void:
	LevelDefinitions.current_level = 1
	LevelDefinitions.current_points = 0
	get_tree().reload_current_scene()


func _on_level_up_button_pressed() -> void:
	LevelDefinitions.current_level += 1
	
	get_tree().reload_current_scene()


func on_level_won():
	level_up_container.show()
	if LevelDefinitions.current_level == LevelDefinitions.levels.size():
		game_won()


func game_won():
	game_won_container.show()
