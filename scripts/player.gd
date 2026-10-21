extends Node2D

signal mosso(nuova_cella : Vector2i)
const SEGMENT_SCENE := preload("res://scenes/body_segment.tscn")

var cella: Vector2i = Grid.ARENA_ORIGIN + Grid.ARENA_SIZE / 2
var direzione: Vector2i = Vector2i.RIGHT
var prossima_direzione: Vector2i = Vector2i.RIGHT
var corpo : Array[Vector2i]
var cresce : bool = false
var segmenti : Array[Node2D] = []
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
	var tocca_corpo : bool = cella_temp in corpo
	var coda_si_sposta : bool = (not corpo.is_empty()
									and cella_temp == corpo.back()
									and not cresce)
	
	if not Grid.is_inside_arena(cella_temp) or (tocca_corpo and not coda_si_sposta):
		print("Game over")
		timer.stop()
		return
	
	corpo.insert(0, cella)
	if cresce:
		cresce = false
		var nuovo := SEGMENT_SCENE.instantiate() as Node2D
		add_child(nuovo)
		segmenti.push_front(nuovo)
	else:
		corpo.remove_at(corpo.size() - 1)
		if not segmenti.is_empty():
			segmenti.push_front(segmenti.pop_back())
	
	if not segmenti.is_empty():
		segmenti[0].position = Grid.cell_to_pixel(cella)
	
	
	cella = cella_temp
	position = Grid.cell_to_pixel(cella)
	sprite_2d.play(ANIM_BY_DIR[direzione])
	mosso.emit(cella)	
	
func cresci() -> void:
	cresce = true
