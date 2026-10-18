class_name Grid
extends Node

const CELL_SIZE := 8
const ARENA_ORIGIN := Vector2i(8, 3)
const ARENA_SIZE := Vector2i(32, 22)

static func cell_to_pixel(cell: Vector2i) -> Vector2:
	return Vector2(cell) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2
	
