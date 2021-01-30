extends Control

## Notes

# Null values in unicode arrays denote a transparent block
# Spaces means something similar. but it will override buffers they are copied to.

## Constants

const SCREEN_CHAR_WIDTH: int  = 40 
const SCREEN_CHAR_HEIGHT: int  = 25

const VOXEL_WIDTH: int = 3
const VOXEL_HEIGHT: int = 3

const CHAR_AT_INV: String = "\ue680"
const CHAR_AT: String = "\ue600"
const CHAR_UP_ARROW: String = "\ue61e"
const CHAR_CORNER_BOT_LEFT: String = "\ue64c"  # L
const CHAR_CORNER_BOT_RIGHT: String = "\ue07a"  # _|  
const CHAR_CORNER_TOP_LEFT: String = "\ue64f"  # |``
const CHAR_CORNER_TOP_RIGHT: String = "\ue650"  # ``|
const CHAR_BOT_BAR: String = "\ue61f"
const CHAR_TOP_BAR: String = "\ue64e"
const CHAR_LEFT_BAR: String = "\ue865"
const CHAR_RIGHT_BAR: String = "\ue867"
const CHAR_DIAG: String = "\ue64b"
const CHAR_ASTERICKS: String = "\ue62a"
const CHAR_EXCLAMATION: String = "\ue621"
const CHAR_QUESTION: String = "\ue43f"
const CHAR_DIAG_STRIPES: String = "\ue869"
const CHAR_HALF_DITHER: String = "\ue866"
const CHAR_X: String = "\ue8d6"
const CHAR_HEART: String = "\u2661"
const CHAR_FILLED_HEART: String = "\ue153"
const CHAR_CIRCLE: String = "\ue157"
const CHAR_FILLED_CIRCLE: String = "\ue151"
const CHAR_DIAMOND: String = "\u2662"
const CHAR_FILLED_DIAMOND: String = "\ue15a"

const VOXEL_1x1: Array = [
	[" ", CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
	[CHAR_RIGHT_BAR, CHAR_DIAG, " ", " ", CHAR_DIAG],
	[CHAR_RIGHT_BAR, " ", CHAR_CORNER_TOP_LEFT, " ", CHAR_RIGHT_BAR],
	[CHAR_RIGHT_BAR, " ", " ", " ", CHAR_RIGHT_BAR],
	[" ", CHAR_DIAG, CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_CORNER_BOT_RIGHT],
]

const VOXEL_ADD_LEFT: Array = [
	[" ", CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
	[CHAR_RIGHT_BAR, CHAR_DIAG, " ", " ", " "],
	[CHAR_RIGHT_BAR, " ", CHAR_CORNER_TOP_LEFT, " ", " ", " "],
	[CHAR_RIGHT_BAR, " ", " ", " ", " ", " "],
	[" ", CHAR_DIAG, CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
]

const VOXEL_ADD_TOP: Array = [
	[" ", CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
	[CHAR_RIGHT_BAR, CHAR_DIAG, " ", " ", CHAR_DIAG],
	[CHAR_RIGHT_BAR, " ", CHAR_CORNER_TOP_LEFT, " ", CHAR_RIGHT_BAR],
	[CHAR_RIGHT_BAR, " ", " ", " ", CHAR_RIGHT_BAR],
	[null, " ", " ", " ", CHAR_RIGHT_BAR],
	[null, " ", " ", " "],
]

const LEFT_L_CORNER: Array = [
	[CHAR_CORNER_BOT_RIGHT],
	[null, CHAR_DIAG],
]

## Locals

onready var Text = $Text
var screen_buffer: Array = []  # 2D Array of strings to write to the text box

# Dummy test world
#	z
#	^
#	|
#	|
#	+-----> x
#	 \
#	  \
#	   v
#	     y
# Test cases for unit tests
#var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 1, 1, 1],
#		[1, 1, 0, 1],
#		[1, 1, 0, 1],
#		[1, 1, 0, 1],
#	],
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#	],
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#	],
#]
var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	[
		[1, 1, 1, 1],
	],
	[
		[0, 0, 0, 1],
	],
	[
		[0, 0, 0, 0],
	],
]

## Builtin Functions

func _ready():
	_clear_screen_buffer()
	_draw_world(world)
	_update_screen()

#	_clear_screen_buffer()
#	var pos: Vector2 = Vector2(32,20)
#	var world_pos = Vector3(3, 0, 0)	
#	_draw_1x1_voxel(pos)
#	_draw_row(3, pos, world_pos)
#	_draw_col(1, pos, world_pos)
#	_update_screen()

#	var pos: Vector2 = Vector2(32,20)
#	var world_pos = Vector3(3, 0, 0)
#	assert(is_there_block_above(world_pos))
#	world_pos.x -= 1
#	assert(is_there_block_above(world_pos) == false)
#	assert(is_there_block_below(world_pos) == false)
#	world_pos = Vector3(3, 0, 0)
#	assert(is_there_block_below(world_pos) == false)
#	world_pos.z += 1
#	assert(is_there_block_below(world_pos) == true)
#	world_pos = Vector3(0, 0, 1)
#	assert(is_there_block_below(world_pos) == false)
#	world_pos = Vector3(1, 0, 0)
#	assert(is_there_block_left(world_pos) == false)
#	world_pos = Vector3(2, 0, 0)
#	assert(is_there_block_left(world_pos) == true)
#	world_pos = Vector3(1, 0, 0)
#	assert(is_there_block_right(world_pos) == true)
#	world_pos = Vector3(1, 0, 1)
#	assert(is_there_block_right(world_pos) == false)
#	world_pos = Vector3(0, 1, 0)
#	assert(is_there_block_infront(world_pos) == true)
#	world_pos = Vector3(0, 0, 1)
#	assert(is_there_block_infront(world_pos) == false)
#	world_pos = Vector3(0, 2, 0)
#	assert(is_there_block_behind(world_pos) == true)
#	world_pos = Vector3(0, 1, 0)
#	assert(is_there_block_behind(world_pos) == false)

#	assert(is_valid_world_pos(Vector3(0, 0, 0)) == true)
#	assert(is_valid_world_pos(Vector3(1, 2, 1)) == true)
#	assert(is_valid_world_pos(Vector3(3, 3, 1)) == true)
#	assert(is_valid_world_pos(Vector3(4, 3, 1)) == false)
#	assert(is_valid_world_pos(Vector3(3, 4, 1)) == false)
#	assert(is_valid_world_pos(Vector3(3, 3, 2)) == false)
#	assert(is_valid_world_pos(Vector3(-1, 3, 1)) == false)

#	assert(_count_y_edge(Vector3(0, 3, 0)) == 3, "Expected 3, was " + str(_count_y_edge(Vector3(0, 3, 0))))
#	var test_pos = Vector3(3, 0, 1)
#	assert(_count_y_edge(test_pos) == 1, "Expected 1, was " + str(_count_y_edge(test_pos)))
#	test_pos = Vector3(3, 3, 0)
#	var expected = 3
#	assert(_count_y_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_y_edge(test_pos)))
#	test_pos = Vector3(3, 0, 0)
#	expected = 0
#	assert(_count_y_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_y_edge(test_pos)))

#   # Tests x edge
#	var test_pos = Vector3(0, 3, 0)
#	var expected = 2
#	assert(_count_x_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_x_edge(test_pos)))
#	test_pos = Vector3(3, 0, 1)
#	expected = 1
#	assert(_count_x_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_x_edge(test_pos)))
#	test_pos = Vector3(3, 0, 0)
#	expected = 0
#	assert(_count_x_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_x_edge(test_pos)))

#	# Tests z edge
#	var test_pos = Vector3(3, 0, 2)
#	var expected = 2
#	assert(_count_z_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_z_edge(test_pos)))
#	test_pos = Vector3(1, 3, 0)
#	expected = 0
#	assert(_count_z_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_z_edge(test_pos)))
#	test_pos = Vector3(0, 3, 0)
#	expected = 1
#	assert(_count_z_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str(_count_z_edge(test_pos)))


##

func _clear_screen_buffer() -> void:
	for x in range(SCREEN_CHAR_HEIGHT):
		var col = []
		col.resize(SCREEN_CHAR_WIDTH)
		screen_buffer.append(col)


func _update_screen() -> void:
	"""
	Write out screen_buffer to the RichTextLabel.
	"""
	assert(len(screen_buffer) <= SCREEN_CHAR_HEIGHT)

	Text.set_text("")
	for row in screen_buffer:
		assert(len(row) <= SCREEN_CHAR_WIDTH)
		for element in row:
			if element == null:         
				Text.text += " "
			else:
				Text.text += element
		Text.text += "\n"
	_clear_screen_buffer()


func is_valid_screen_coord(point: Vector2) -> bool:
	return (point.y < SCREEN_CHAR_HEIGHT) and \
		(point.x < SCREEN_CHAR_WIDTH)


func _copy_into_screen_buffer(src: Array, dest: Vector2) -> bool:
	"""
	Args:
		dest: the 2D coordinates in screen_buffer where we will copy the src.
			The dest points to the _top left_ of where the src is copied to.
		src: 2D Array of strings. If any element of the array is null, 
			then do not copy that character. 
			If src cannot fit into the screen buffer, it will be cut off.
			Writing a " " (space) clears the existing character.
	"""
	if not is_valid_screen_coord(dest):
		return false
	
	for y in range(len(src)):
		for x in range(len(src[y])):
			if src[y][x] != null:
				screen_buffer[dest.y + y][dest.x + x] = src[y][x]

	return true


func _draw_1x1_voxel(pos: Vector2) -> bool:
	# FIXME - check that pos is in bounds and handle drawing part of a cube
	_copy_into_screen_buffer(VOXEL_1x1, pos)
	return true


func _draw_row(num_voxels: int, pos: Vector2, world_pos: Vector3) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
		world_pos: position of the existing block in the 3D world
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.
	
	for i in range(num_voxels):
		pos.x -= VOXEL_WIDTH
		world_pos.x -= 1
		_add_voxel_left(pos, world_pos)
	return true


func _draw_col(num_voxels: int, pos: Vector2, world_pos: Vector3) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
		world_pos: position of the existing block in the 3D world
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.
	
	for i in range(num_voxels):
		pos.y -= VOXEL_HEIGHT
		world_pos.z += 1
		_add_voxel_top(pos, world_pos)
	return true


func _add_voxel_left(pos:Vector2, world_pos: Vector3) -> bool:
	"""
	Draws a new voxel to the left assuming this voxel is the bottom layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
		world_pos: position of the new block in the 3D world
	"""
#   # Check if the voxel to our left matches the shape we expect...
#   var pos_right: Vector2 = pos + Vector2(3, 0)
#   if not _check_screen_buffer_equal(VOXEL_ADD_LEFT, pos_right):
#       return false
	# FIXME - need to create the array to represent the left part of a 1x1 cube.
	
	_copy_into_screen_buffer(VOXEL_ADD_LEFT, pos)
	
	# Erase horizontal interior lines
	var offset_pos_to_old_interior_horiz_line: Vector2 = Vector2(6, 2)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_horiz_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_TOP_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		screen_pos.x += 1
	
	# Draw new interior lines. Should draw two more than old value. 
	var num_interior_horiz_lines = _count_x_edge(world_pos)
	var offset_pos_to_interior_horiz_line: Vector2 = Vector2(3, 2)  # Constant
	screen_pos = pos + offset_pos_to_interior_horiz_line
	for i in range(num_interior_horiz_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_TOP_BAR
		screen_pos.x += 1

	return true


func _add_voxel_top(pos:Vector2, world_pos: Vector3) -> bool:
	"""
	Draws a new voxel on top of an existing voxel. Assumes new voxel to be added
	is the top most layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
		world_pos: position of the new block in the 3D world
	"""
	# FIXME - need to create the array to represent the left part of a 1x1 cube.
	
	if world[world_pos.z - 1][world_pos.y][world_pos.x] == 0:
		# Error out since this block doesn't exist.
		assert("We assume we're ADDING on top of an existing block.")
	
	_copy_into_screen_buffer(VOXEL_ADD_TOP, pos) 

	# Erase vertical interior lines
	var offset_pos_to_old_interior_vert_line: Vector2 = Vector2(2, 6)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_vert_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_LEFT_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		screen_pos.y += 1
	
	# Draw new interior lines. 
	var num_interior_vert_lines = _count_z_edge(world_pos) - 1
	var offset_pos_to_interior_vert_line: Vector2 = Vector2(2, 3)  # Constant
	screen_pos = pos + offset_pos_to_interior_vert_line
	for i in range(num_interior_vert_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_LEFT_BAR
		screen_pos.y += 1

	## Special cases!
	
	# If block exists (below and to the left).
	if world[world_pos.z - 1][world_pos.y][world_pos.x - 1] > 0:
		var offset_pos_to_corner: Vector2 = Vector2(0, 3)  # Constant]
		screen_pos = pos + offset_pos_to_corner
		_copy_into_screen_buffer(LEFT_L_CORNER, screen_pos)

	return true


## 
# Dummy world functions that will be replaced later

# All these functions assume world_pos is a valid point in the world.

func is_there_block_above(world_pos: Vector3) -> bool:
	if (world_pos.z + 1) >= len(world):
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z + 1][world_pos.y][world_pos.x] > 0


func is_there_block_below(world_pos: Vector3) -> bool:
	if (world_pos.z - 1) < 0:
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z - 1][world_pos.y][world_pos.x] > 0


func is_there_block_left(world_pos: Vector3) -> bool:
	if (world_pos.x - 1) < 0:
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z][world_pos.y][world_pos.x - 1] > 0


func is_there_block_right(world_pos: Vector3) -> bool:
	if (world_pos.x + 1) >= len(world[0][0]):
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z][world_pos.y][world_pos.x + 1] > 0


func is_there_block_behind(world_pos: Vector3) -> bool:
	if (world_pos.y - 1) < 0:
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z][world_pos.y - 1][world_pos.x] > 0


func is_there_block_infront(world_pos: Vector3) -> bool:
	if (world_pos.y + 1) >= len(world[0]):
		# Out of bounds index. No blocks exist there.
		return false
	return world[world_pos.z][world_pos.y + 1][world_pos.x] > 0


func is_valid_world_pos(world_pos: Vector3) -> bool:
	return ((world_pos.z >= 0) && (world_pos.z < len(world))) \
		&& ((world_pos.y >= 0) && (world_pos.y < len(world[0]))) \
		&& ((world_pos.x >= 0) && (world_pos.x < len(world[0][0])))


func voxel_exists_at_pos(world_pos: Vector3) -> bool:
	return world[world_pos.z][world_pos.y][world_pos.x] > 0

##

func _count_y_edge(world_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the y direction starting at 
	world_pos. This function assumes there are no blocks in FRONT of world_pos. 
	Notes: y defined the back to front dimension.
	""" 
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = world_pos
	while not found_new_plane:
		if world[cur_pos.z][cur_pos.y][cur_pos.x] == 0:
			break
		
		found_new_plane = found_new_plane or is_there_block_above(cur_pos)
		found_new_plane = found_new_plane or is_there_block_left(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.y -= 1

		if not is_valid_world_pos(cur_pos):
			break
		
	return edge_len
		

func _count_x_edge(world_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the x direction starting at 
	world_pos. This function assumes there are no blocks to the left of world_pos. 
	Notes: x defined the left to right dimension.
	""" 
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = world_pos
	while not found_new_plane:
		if world[cur_pos.z][cur_pos.y][cur_pos.x] == 0:
			break
		
		found_new_plane = found_new_plane or is_there_block_above(cur_pos)
		found_new_plane = found_new_plane or is_there_block_infront(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.x += 1

		if not is_valid_world_pos(cur_pos):
			break
		
	return edge_len


func _count_z_edge(world_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the z direction starting at 
	world_pos. This function assumes there are no blocks above world_pos. 
	Notes: z defined the up to down dimension.
	""" 
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = world_pos
	while not found_new_plane:
		if world[cur_pos.z][cur_pos.y][cur_pos.x] == 0:
			break
		
		found_new_plane = found_new_plane or is_there_block_left(cur_pos)
		found_new_plane = found_new_plane or is_there_block_infront(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.z -= 1

		if not is_valid_world_pos(cur_pos):
			break
		
	return edge_len


func _draw_world(world: Array) -> bool:
	"""
	Draws the entire world to the screen. 
	"""
	# FIXME - don't hard code the screen pos. Need to programmatically figure it out...
	var screen_pos: Vector2 = Vector2(35, 10)
	
	var cur_pos: Vector2 = screen_pos
	
	# Traverse back to front
	for y in range(len(world[0])):
		# Traverse bottom to top
		for z in range(len(world)):
			cur_pos.x = screen_pos.x
			# Traverse from right to left
			for x in range(len(world[0][0]) - 1, -1, -1):
				var world_pos: Vector3 = Vector3(x, y, z)
				if not voxel_exists_at_pos(world_pos):
					continue
				
				if not is_there_block_right(world_pos) and \
					not is_there_block_below(world_pos):
					_draw_1x1_voxel(cur_pos)
				elif not is_there_block_right(world_pos) and \
					is_there_block_below(world_pos):
					_add_voxel_top(cur_pos, world_pos)
				elif is_there_block_right(world_pos) and \
					not is_there_block_below(world_pos):
					_add_voxel_left(cur_pos, world_pos)
				else:
					# FIXME - still need to code this case!!! 
					assert("FIXME")
				cur_pos.x -= VOXEL_WIDTH
			cur_pos.y -= VOXEL_WIDTH
		cur_pos.y += 1
	return true
