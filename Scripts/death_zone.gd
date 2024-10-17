extends Area2D
class_name DeathZone

signal life_lost


func _on_body_entered(_body: Node2D) -> void:
	life_lost.emit()
