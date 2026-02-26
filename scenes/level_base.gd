class_name kevincraft_level_base extends GridMap

@onready var target_block = preload("res://objects/target_block.tscn")

var placeable_blocks: Dictionary[Vector3i, int] = {}
var target_blocks: Dictionary[Vector3i, MeshInstance3D] = {}

var potential_blocks: Array[Vector3i] = []

var total_blocks_to_place: int # set to size of placeable blocks on each new game

var game: Node3D

func start():
	game = get_parent()
	make_target_blocks(game.ultra_hardcore_difficulty)
	total_blocks_to_place = placeable_blocks.size()
	game.update_blocks_left(placeable_blocks.size(), total_blocks_to_place)

## Method to be overriden by children.
func make_target_blocks(difficulty: float):
	add_individual_block(Vector3i(0, 3, 1))

func add_individual_block(pos: Vector3i):
	# block ends up in array of target blocks, so long as the block exists
	if get_cell_item(pos) != -1:
		placeable_blocks.set(pos, self.get_cell_item(pos))
		var new_target_block = target_block.instantiate()
		game.add_child(new_target_block)
		target_blocks.set(pos, new_target_block)
		new_target_block.position = map_to_local(pos)
		set_cell_item(pos, -1)

func build_block(tile_pos: Vector3i, tile: int) -> bool: # returns true if block placed is a placeable block, otherwise returns false
	if placeable_blocks.has(tile_pos):
		# builds the block at the cell that matches the missing block, then removes it from the required blocks to build
		set_cell_item(tile_pos, placeable_blocks[tile_pos])
		placeable_blocks.erase(tile_pos)
		target_blocks[tile_pos].queue_free()
		target_blocks.erase(tile_pos)
		# update game display
		game.update_blocks_left(placeable_blocks.size(), total_blocks_to_place)
		# win condition!
		if placeable_blocks.is_empty():
			game.win_game()
		return true
	else:
		# otherwise just places player's block
		set_cell_item(tile_pos, tile)
	return false

func try_to_add_potential_block(tile_pos: Vector3i):
	if get_cell_item(tile_pos) != -1:
		potential_blocks.append(tile_pos)

func get_player() -> CharacterBody3D:
	return get_node("Player")
