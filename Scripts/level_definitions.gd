extends Node

var current_level = 1

var level_1 = [
	[0, 1, 0]
]

var level_2 = [
	[0, 1, 2, 0]
]

var levels = [level_1, level_2]

func get_current_level():
	return levels[current_level-1]
