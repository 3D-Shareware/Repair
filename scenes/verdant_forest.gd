extends kevincraft_level_base

func make_target_blocks(difficulty: float):
	# back porch wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3(2, 4 + j, 5 + i))
	# back porch
	if difficulty > 1.3:
		for i in 5:
			for j in 3:
				try_to_add_potential_block(Vector3(3 + j, 3, 5 + i))
	# right-facing wall
	for i in 10:
		for j in 3:
			try_to_add_potential_block(Vector3(-12, 4 + j, i))
	# sun-facing wall
	for i in 13:
		for j in 3:
			try_to_add_potential_block(Vector3(-11 + i, 4 + j, 10))
	# small wall
	for i in 7:
		for j in 3:
			try_to_add_potential_block(Vector3(-5 + i, 4 + j, 4))
	# left small wall
	for i in 4:
		for j in 3:
			try_to_add_potential_block(Vector3(-6, 4 + j, i))
	# front wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3(-11 + i, 4 + j, -1))
	# front porch
	if difficulty > 1.3:
		for i in 5:
			for j in 3:
				try_to_add_potential_block(Vector3(-11 + i, 3, -4 + j))
	
	@warning_ignore("narrowing_conversion")
	for i in clampi(difficulty * 15.1 - 12, 3, 24):
		if potential_blocks.is_empty():
			break
		add_individual_block(potential_blocks.pop_at(randi_range(0, potential_blocks.size() - 1)))
