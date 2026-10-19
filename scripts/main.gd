extends Node

const FOOD_SCENE := preload("res://scenes/food.tscn")

@onready var food: Node2D = $Food
@onready var player: Node2D = $Player

func _ready() -> void:
	food = FOOD_SCENE.instantiate()
	add_child(food)
	food.posiziona(Grid.random_cell())

func _on_player_mosso(nuova_cella: Vector2i) -> void:
	if player.cella == food.cella:
		print("Mangiato")
