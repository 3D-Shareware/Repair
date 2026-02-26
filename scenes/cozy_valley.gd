extends kevincraft_level_base

func make_target_blocks(difficulty: float):
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3(i - 2, 4 + j, 3))
	if difficulty > 1.1:
		for i in 5:
			for j in 3:
				try_to_add_potential_block(Vector3(i - 2, 4 + j, -3))
		for k in 2:
			for i in 5:
				for j in 3:
					try_to_add_potential_block(Vector3(3 * (1 - (2 * k)), 4 + j, i - 2))
	if difficulty > 1.5:
		for i in 5:
			for j in 5:
				try_to_add_potential_block(Vector3(i - 2, 3, j - 2))
		for i in 5:
			for j in 5:
				try_to_add_potential_block(Vector3(i - 2, 7, j - 2))
	
	@warning_ignore("narrowing_conversion")
	for i in clampi(difficulty * 25.1 - 20, 5, 40):
		if potential_blocks.is_empty():
			break
		add_individual_block(potential_blocks.pop_at(randi_range(0, potential_blocks.size() - 1)))
