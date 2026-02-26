extends kevincraft_level_base

func make_target_blocks(difficulty: float):
	# front lower wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(i - 2, 4 + j, 7))
	# front upper wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(i - 2, 8 + j, 7))
	# front tower bits
	for i in 5:
		for j in 2:
			try_to_add_potential_block(Vector3i(i - 2, 12 + j, 7))
	# back upper wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(i - 2, 8 + j, 13))
	# back tower bits
	for i in 5:
		for j in 2:
			try_to_add_potential_block(Vector3i(i - 2, 12 + j, 13))
	
	# left lower wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(3, 4 + j, i + 8))
	# left upper wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(3, 8 + j, i + 8))
	# left tower bits
	for i in 5:
		for j in 2:
			try_to_add_potential_block(Vector3i(3, 12 + j, i + 8))
	
	# right lower wall
	for i in 5:
		for j in 3:
			try_to_add_potential_block(Vector3i(-3, 4 + j, i + 8))
	# right tower bits
	for i in 5:
		for j in 2:
			try_to_add_potential_block(Vector3i(-3, 12 + j, i + 8))
	
	# the stairs
	for i in 4:
		try_to_add_potential_block(Vector3i(1 - i, 4 + i, 12))
	# the upper stairs
	for i in 3:
		try_to_add_potential_block(Vector3i(-2, 8 + i, 11 - i))
	
	if difficulty > 1.5:
		# floor
		for i in 5:
			for j in 4:
				try_to_add_potential_block(Vector3i(i - 2, 3, 8 + j))
		# second floor
		for i in 5:
			for j in 4:
				try_to_add_potential_block(Vector3i(i - 2, 7, 8 + j))
		# top floor
		for i in 5:
			for j in 5:
				try_to_add_potential_block(Vector3i(i - 2, 11, 8 + j))
		# the porch
		for i in 7:
			for j in 3:
				try_to_add_potential_block(Vector3i(i - 3, 3, 4 + j))
	
	@warning_ignore("narrowing_conversion")
	for i in clampi(difficulty * 12.6 - 10, 5, 20):
		if potential_blocks.is_empty():
			break
		add_individual_block(potential_blocks.pop_at(randi_range(0, potential_blocks.size() - 1)))
