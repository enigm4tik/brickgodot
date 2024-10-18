extends Node

var current_level: int = 1
var current_points: int = 0
var current_lives:int = 3

var level1: Array[Array] = [
	[1, 1, 1, 1, 1], 
	[1, 1, 1, 1, 1], 
	[1, 1, 1, 1, 1], 
]

var level2: Array[Array] = [
	[3, 3, 3, 3, 3],
	[2, 2, 2, 2, 2],
	[1, 1, 1, 1, 1]
]

var level3: Array[Array] = [
	[4, 4, 4, 4, 4],
	[3, 3, 3, 3, 3],
	[2, 2, 2, 2, 2],
	[1, 1, 1, 1, 1]
]

var level4: Array[Array] = [
	[5, 5, 5, 5, 5],
	[4, 4, 4, 4, 4],
	[3, 3, 3, 3, 3],
	[2, 2, 2, 2, 2],
	[1, 1, 1, 1, 1]
]

var level5: Array[Array] = [
	[3, 5, 3, 5, 3],
	[5, 5, 5, 5, 5],
	[5, 5, 5, 5, 5],
	[3, 5, 5, 5, 3],
	[3, 3, 5, 3, 3]
]

var level6: Array[Array] = [
	[1, 2, 1, 2, 1],
	[2, 0, 2, 0, 2],
	[2, 3, 2, 3, 2],
	[5, 2, 2, 2, 5],
	[2, 2, 3, 2, 2],
	[1, 2, 2, 2, 1],
]

var levels: Array[Array] = [level1, level2, level3, level4, level5, level6]

func get_current_level() -> Array:
	return levels[current_level-1]
