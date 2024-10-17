extends CanvasLayer

class_name UI

@onready var lives_label: Label = %LivesLabel
@onready var game_over_container: CenterContainer = %GameOverContainer
@onready var level_up_container: CenterContainer = %LevelUpContainer

func set_lives(lives: int):
	lives_label.text = "Lives: %d" % lives

func game_over(): 
	game_over_container.show()

func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()

func _on_level_up_button_pressed() -> void:
	LevelDefinitions.current_level += 1
	get_tree().reload_current_scene()

func on_level_won():
	level_up_container.show()
