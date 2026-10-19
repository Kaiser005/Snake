class_name Grid
extends RefCounted


const CELL_SIZE := 8
const ARENA_ORIGIN := Vector2i(8, 3)
const ARENA_SIZE := Vector2i(32, 22)
const PLAY_MIN := ARENA_ORIGIN + Vector2i.ONE
const PLAY_MAX := ARENA_SIZE + ARENA_ORIGIN - (Vector2i.ONE * 2)

static func cell_to_pixel(cell: Vector2i) -> Vector2:
	return Vector2(cell) * CELL_SIZE + Vector2.ONE * CELL_SIZE / 2
	

static func is_inside_arena(cell: Vector2i) -> bool:
	return (cell.x >= PLAY_MIN.x 
			and cell.x <= PLAY_MAX.x
			and cell.y >= PLAY_MIN.y 
			and cell.y <= PLAY_MAX.y
			)

static func random_cell() -> Vector2i:
	return Vector2i(randi_range(PLAY_MIN.x, PLAY_MAX.x), randi_range(PLAY_MIN.y, PLAY_MAX.y))
