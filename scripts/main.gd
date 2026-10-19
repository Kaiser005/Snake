extends Node

const FOOD_SCENE := preload("res://scenes/food.tscn")

@onready var food: Node2D = $Food

func _ready() -> void:
	food = FOOD_SCENE.instantiate()
	add_child(food)
	food.posiziona(Grid.random_cell())
