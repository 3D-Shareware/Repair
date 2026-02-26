extends CPUParticles3D

var colors = [
	Color("4d3523"), # grass
	Color("4d3523"), # dirt
	Color("7f1919"), # brick
	Color("906d42"), # planks
	Color("49341a"), # wood
	Color("3c9c5a"), # leaves
	Color("4e485c") # stone
]

func start(id: int):
	color = colors[id]
	restart()


func _on_finished() -> void:
	queue_free()
