extends Node2D


var cella: Vector2i = Grid.ARENA_ORIGIN + Grid.ARENA_SIZE / 2
var direzione: Vector2i = Vector2i.RIGHT
var prossima_direzione: Vector2i = Vector2i.RIGHT
@onready var sprite_2d: AnimatedSprite2D = $CharacterBody2D/Sprite2D
@onready var timer: Timer = $"../Timer"

const ANIM_BY_DIR := {
	Vector2i.UP: "Up",
	Vector2i.DOWN: "Down",
	Vector2i.LEFT: "Left",
	Vector2i.RIGHT: "Right",
}



func _ready() -> void:
	position = Grid.cell_to_pixel(cella)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("down") and direzione + Vector2i.DOWN != Vector2i.ZERO:
		prossima_direzione = Vector2i.DOWN
	elif event.is_action_pressed("up") and direzione + Vector2i.UP != Vector2i.ZERO:
		prossima_direzione = Vector2i.UP
	elif event.is_action_pressed("left") and direzione + Vector2i.LEFT != Vector2i.ZERO:
		prossima_direzione = Vector2i.LEFT
	elif event.is_action_pressed("right") and direzione + Vector2i.RIGHT != Vector2i.ZERO:
		prossima_direzione = Vector2i.RIGHT


func _on_timer_timeout() -> void:
	direzione = prossima_direzione
	var cella_temp = cella + prossima_direzione
	if not Grid.is_inside_arena(cella_temp):
		print("Game over")
		timer.stop()
		return
	cella += prossima_direzione
	position = Grid.cell_to_pixel(cella)
	sprite_2d.play(ANIM_BY_DIR[direzione])
