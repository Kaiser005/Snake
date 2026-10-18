class_name Grid
extends Node

const CELL_SIZE := 8
const ARENA_ORIGIN := Vector2i(8, 3)
const ARENA_SIZE := Vector2i(32, 22)

static func cell_to_pixel(cell: Vector2i) -> Vector2:
	return Vector2(cell) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2
	

static func is_inside_arena(cell: Vector2i) -> bool:
	return (cell.x >= ARENA_ORIGIN.x + 1 
			and cell.x <= ARENA_SIZE.x + ARENA_ORIGIN.x - 2 
			and cell.y >= ARENA_ORIGIN.y + 1 
			and cell.y <= ARENA_SIZE.y + ARENA_ORIGIN.y - 2
			)
