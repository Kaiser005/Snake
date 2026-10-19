extends Node2D


var cella : Vector2i

func posiziona(nuova: Vector2i) -> void:
	cella = nuova
	position = Grid.cell_to_pixel(cella)
