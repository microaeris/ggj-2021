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

const VOXEL_ADD_TOP_LEFT: Array = [
	[" ", CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
	[CHAR_RIGHT_BAR, CHAR_DIAG, " ", " ", " "],
	[CHAR_RIGHT_BAR, " ", CHAR_CORNER_TOP_LEFT, " ", " ", " "],
	[CHAR_RIGHT_BAR, " ", " ", " ", " ", " "],
	[null, " ", " ", " ", " "],
	[null, " ", " ", " "],
]

const VOXEL_ADD_INFRONT: Array = [
	[null, null, null, null],
	[" ", CHAR_DIAG, " ", " ", CHAR_DIAG],
	[" ", " ", CHAR_CORNER_TOP_LEFT, " ", CHAR_RIGHT_BAR],
	[null, " ", " ", " ", CHAR_RIGHT_BAR],
	[" ", CHAR_DIAG, CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_CORNER_BOT_RIGHT],
]

const VOXEL_ADD_INFRONT_TOP: Array = [
	[" ", null, null, null],
	[" ", CHAR_DIAG, " ", " ", CHAR_DIAG],
	[" ", " ", CHAR_CORNER_TOP_LEFT, " ", CHAR_RIGHT_BAR],
	[" ", " ", " ", " ", CHAR_RIGHT_BAR],
	[" ", " ", " ", " ", CHAR_RIGHT_BAR],
	[" ", " ", " ", " ", null],
]

const VOXEL_ADD_INFRONT_LEFT: Array = [
	[" ", null, null, null],
	[" ", CHAR_DIAG, " ", " ", " "],
	[" ", " ", CHAR_CORNER_TOP_LEFT, " ", " ", " "],
	[null, " ", " ", " ", " "],
	[" ", CHAR_DIAG, CHAR_BOT_BAR, CHAR_BOT_BAR, CHAR_BOT_BAR],
]

const VOXEL_ADD_INFRONT_TOP_LEFT: Array = [
	[" ", null, null, null],
	[null, CHAR_DIAG, " ", " ", " "],
	[" ", " ", CHAR_CORNER_TOP_LEFT, " ", " ", " "],
	[null, " ", " ", " ", " ", " "],
	[null, " ", " ", " ", " "],
	[null, " ", " ", " ", " "]
]

## Locals

onready var Text = $Text
var screen_buffer: Array = []  # 2D Array of strings to write to the text box

# Coordinate system
#	z - column
#	^
#	|
#	|
#	+-----> x - row
#	 \
#	  \
#	   v
#	     y - diag

## Builtin Functions

func _ready():
	var map_name = "TestMap1.map"  # TODO(jm) Don't hardcode
	$Map.load_map(map_name)

	var pos: Vector2 = Vector2(20, 10)
	clear_screen_buffer()
	draw_map($Map.map, pos)
	print(hash_screen_buffer())
	update_screen()

##

func clear_screen_buffer() -> void:
	screen_buffer = []
	for x in range(SCREEN_CHAR_HEIGHT):
		var col = [null]
		col.resize(SCREEN_CHAR_WIDTH)
		screen_buffer.append(col)


func update_screen() -> void:
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
	clear_screen_buffer()


func print_screen_buffer() -> void:
	print("[")
	for row in screen_buffer:
		print(row, ",")
		# Add a delay in printing else Godot complains about overflowing the output buffer
		yield(get_tree().create_timer(.5), "timeout")
	print("]")


func hash_screen_buffer() -> String:
	"""
	Function used in unit tests.
	"""
	# Return calculated hash
	return str(screen_buffer).sha1_text()


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


func draw_1x1_voxel(pos: Vector2) -> bool:
	# FIXME - check that pos is in bounds and handle drawing part of a cube
	_copy_into_screen_buffer(VOXEL_1x1, pos)
	return true


func draw_row(num_voxels: int, pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
		map_pos: position of the existing block in the 3D map
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.

	for i in range(num_voxels):
		pos.x -= VOXEL_WIDTH
		map_pos.x -= 1
		_add_voxel_left(pos, map_pos)
	return true


func draw_col(num_voxels: int, pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
		map_pos: position of the existing block in the 3D map
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.

	for i in range(num_voxels):
		pos.y -= VOXEL_HEIGHT
		map_pos.z += 1
		_add_voxel_top(pos, map_pos)
	return true


func _add_voxel_left(pos:Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel to the left assuming this voxel is the bottom layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
#   # Check if the voxel to our left matches the shape we expect...
#   var pos_right: Vector2 = pos + Vector2(3, 0)
#   if not _check_screen_buffer_equal(VOXEL_ADD_LEFT, pos_right):
#       return false
	# FIXME - need to create the array to represent the left part of a 1x1 cube.

	_copy_into_screen_buffer(VOXEL_ADD_LEFT, pos)
	_fix_horiz_interior_lines(pos, map_pos)
	_fix_left_t_corner(pos, map_pos)  # Special case
	_fix_flat_left_l_corner(pos, map_pos)  # Special case

	return true


func _add_voxel_top(pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel on top of an existing voxel. Assumes new voxel to be added
	is the top most layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
	# FIXME - need to create the array to represent the left part of a 1x1 cube.

	if not $Map.is_there_block_below(map_pos):
		# Error out since this block doesn't exist.
		assert("We assume we're ADDING on top of an existing block.")

	_copy_into_screen_buffer(VOXEL_ADD_TOP, pos)
	_fix_vert_interior_lines(pos, map_pos)
	_fix_left_l_corner(pos, map_pos)  # Special case
	_fix_right_l_corner(pos, map_pos)  # Special case
	_fix_backwards_l_corner(pos, map_pos)  # Special case

	return true


func _add_voxel_top_left(pos:Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel on top and to the left of an existing voxel. Assumes new
	voxel to be added is the top most layer and as the left most block
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
	if not $Map.is_there_block_right(map_pos):
		# Error out since this block doesn't exist.
		assert("We assume we're ADDING to an existing block.")

	_copy_into_screen_buffer(VOXEL_ADD_TOP_LEFT, pos)
	_fix_vert_interior_lines(pos, map_pos)
	_fix_horiz_interior_lines(pos, map_pos)
	_fix_left_l_corner(pos, map_pos)  # Special case
	_fix_flat_left_l_corner(pos, map_pos)  # Special case
	_fix_right_t_corner(pos, map_pos)  # Special case
	_fix_backwards_l_corner(pos, map_pos)  # Special case
	return true


func _add_voxel_infront(pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel infront of an existing voxel. Assumes new voxel to be
	added has no voxels to its left, above it or in front of it.
	Increases the interior line length and moves it over.

	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""

	if not $Map.is_there_block_behind(map_pos):
		# Error out since this block doesn't exist.
		assert("We assume we're ADDING to an existing block.")
	if $Map.is_there_block_right(map_pos):
		assert("No blocks allowed to the right!!")
	if $Map.is_there_block_below(map_pos):
		assert("No blocks allowed below!!")

	_copy_into_screen_buffer(VOXEL_ADD_INFRONT, pos)

	## Extra special case!
	if screen_buffer[pos.y][pos.x] == CHAR_DIAG:
		screen_buffer[pos.y][pos.x] = " "

	_fix_diag_interior_lines(pos, map_pos)
	_fix_flat_right_t_corner(pos, map_pos)  # Special case
	_fix_forward_t_corner(pos, map_pos)  # Special case
	_fix_forward_l_corner(pos, map_pos)  # Special case

	# Extra special case
	# Retain the interior lines added by a previous block's call to _fix_forward_l_corner.
	map_pos -= Vector3(0, 1, 0)
	pos -= Vector2(1, 1)
	_fix_forward_l_corner(pos, map_pos)

	return true


func _add_voxel_infront_and_top(pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel infront of an existing voxel. This same new voxel is also
	on top of an existing voxel. Assumes new voxel to be added has no voxels to
	its left, above it or in front of it and to its right.
	Increases the interior line length and moves it over.

	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
	if not $Map.is_there_block_behind(map_pos):
		assert("We asssume we're ADDING an existing block!")
	if not $Map.is_there_block_below(map_pos):
		assert("We assume we're ADDING an existing block!")

	# FIXME - maybe i should add asserts to check that there are no blocks
	# to the left, right, above and in front. I sorta want the flexibility to
	# hack the renderer though for test cases. ehhh..

	_copy_into_screen_buffer(VOXEL_ADD_INFRONT_TOP, pos)
	_fix_diag_interior_lines(pos, map_pos)
	_fix_vert_interior_lines(pos, map_pos)
	_fix_flat_right_t_corner(pos, map_pos)  # Special case
	_fix_backwards_t_corner(pos, map_pos)  # Special case

	return true


func _add_voxel_infront_and_left(pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel infront of an existing voxel. This same new voxel is also
	to the left of an existing voxel. Assumes new voxel to be added has no
	voxels to _its_ left, above it or in front of it and to its right.
	Increases the interior line length and moves it over.

	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
	if not $Map.is_there_block_behind(map_pos):
		assert("We asssume we're ADDING an existing block!")
	if not $Map.is_there_block_right(map_pos):
		assert("We assume we're ADDING an existing block!")

	# FIXME - maybe i should add asserts to check that there are no blocks
	# to the left, right, above and in front. I sorta want the flexibility to
	# hack the renderer though for test cases. ehhh..

	_copy_into_screen_buffer(VOXEL_ADD_INFRONT_LEFT, pos)
	_fix_diag_interior_lines(pos, map_pos)
	_fix_horiz_interior_lines(pos, map_pos)
	_fix_forward_t_corner(pos, map_pos)  # Special case
	_fix_forward_l_corner(pos, map_pos)  # Special case
	_fix_flat_right_l_corner(pos, map_pos)  # Special case

	return true


func _add_voxel_infront_and_left_top(pos: Vector2, map_pos: Vector3) -> bool:
	"""
	Draws a new voxel infront of an existing voxel. This same new voxel is also
	to the left of an existing voxel. It is ALSO on top of another voxel!
	Assumes new voxel to be added has no voxels to _its_ left, above it or in
	front of it and to its right.
	Increases the interior line length and moves it over.

	Args
		pos: position in screen buffer to draw the new voxel.
		map_pos: position of the new block in the 3D map
	"""
	if not $Map.is_there_block_behind(map_pos):
		assert("We asssume we're ADDING an existing block!")
	if not $Map.is_there_block_right(map_pos):
		assert("We assume we're ADDING an existing block!")
	if not $Map.is_there_block_below(map_pos):
		assert("We assume we're ADDING an existing block!")

	# FIXME - maybe i should add asserts to check that there are no blocks
	# to the left, right, above and in front. I sorta want the flexibility to
	# hack the renderer though for test cases. ehhh..

	_copy_into_screen_buffer(VOXEL_ADD_INFRONT_TOP_LEFT, pos)
	_fix_diag_interior_lines(pos, map_pos)
	_fix_horiz_interior_lines(pos, map_pos)
	_fix_vert_interior_lines(pos, map_pos)
	_fix_flat_right_l_corner(pos, map_pos)  # Special case
	_fix_right_t_corner(pos, map_pos)  # Special case
	_fix_backwards_t_corner(pos, map_pos)  # Special case

	return true


func _fix_vert_interior_lines(pos: Vector2, map_pos: Vector3) -> void:
	# Erase vertical interior lines
	var offset_pos_to_old_interior_vert_line: Vector2 = Vector2(2, 6)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_vert_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_LEFT_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		screen_pos.y += 1

	# Draw new interior lines.
	var num_interior_vert_lines = count_z_edge(map_pos)

	# Special case to round down the number of interior lines. If there's only
	# 1 block, draw no extra interior edges.
	if num_interior_vert_lines == 1:
		num_interior_vert_lines = 0

	_draw_new_interior_vert_lines(pos, num_interior_vert_lines)


func _fix_horiz_interior_lines(pos: Vector2, map_pos: Vector3) -> void:
	# Erase horizontal interior lines
	var offset_pos_to_old_interior_horiz_line: Vector2 = Vector2(6, 2)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_horiz_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_TOP_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		screen_pos.x += 1

	# Draw new interior lines.
	var num_interior_horiz_lines = count_x_edge(map_pos)

	# Special case to round down the number of interior lines. If there's only
	# 1 block, draw no extra interior edges.
	if num_interior_horiz_lines == 1:
		num_interior_horiz_lines = 0

	_draw_new_interior_horiz_lines(pos, num_interior_horiz_lines)


func _fix_diag_interior_lines(pos: Vector2, map_pos: Vector3) -> void:
	# Erase diag interior lines
	var offset_pos_to_old_interior_diag_line: Vector2 = Vector2(2, 2)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_diag_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_DIAG):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		screen_pos.y -= 1
		screen_pos.x -= 1

	# Draw new interior lines.
	var num_interior_diag_lines = count_y_edge(map_pos)

	# Special case to round down the number of interior lines. If there's only
	# 1 block, draw no extra interior edges.
	if num_interior_diag_lines <= 3:
		num_interior_diag_lines = 0
	else:
		num_interior_diag_lines -= 3

	_draw_new_interior_diag_lines(pos, num_interior_diag_lines)


func _draw_new_interior_horiz_lines(pos: Vector2, num_lines: int) -> void:
	var offset_pos_to_interior_horiz_line: Vector2 = Vector2(3, 2)  # Constant
	var screen_pos = pos + offset_pos_to_interior_horiz_line
	for i in range(num_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_TOP_BAR
		screen_pos.x += 1


func _draw_new_interior_vert_lines(pos: Vector2, num_lines: int) -> void:
	var offset_pos_to_interior_vert_line: Vector2 = Vector2(2, 3)  # Constant
	var screen_pos = pos + offset_pos_to_interior_vert_line
	for i in range(num_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_LEFT_BAR
		screen_pos.y += 1


func _draw_new_interior_diag_lines(pos: Vector2, num_lines: int) -> void:
	var offset_pos_to_interior_vert_line: Vector2 = Vector2(1, 1)  # Constant
	var screen_pos = pos + offset_pos_to_interior_vert_line
	for i in range(num_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG
		screen_pos.y -= 1
		screen_pos.x -= 1


#       ___
#	   |\__\
#	___||  |
#  |\___*  |
#  \|______|
func _fix_left_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If block exists (below and to the left).
	var temp: Vector3 = map_pos - Vector3(1, 0, 1)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_corner: Vector2 = Vector2(0, 3)  # Constant
			var screen_pos = pos + offset_pos_to_corner
			_copy_into_screen_buffer(LEFT_L_CORNER, screen_pos)


#   ___
#  |\__\
#  ||  |___
#  ||  *___\
#  \|______|
func _fix_right_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If block does not exist to the new block's right
	# and if a block exists below and to the right
	var temp: Vector3 = map_pos + Vector3(1, 0, 0)
	var temp_2: Vector3 = map_pos + Vector3(1, 0, -1)
	if $Map.is_valid_pos(temp) and $Map.is_valid_pos(temp_2):
		if not $Map.voxel_exists_at_pos(temp) and \
			$Map.voxel_exists_at_pos(temp_2):
			# This draws the horiz lines starting where the inner |`` is.
			# This doesn't follow how the other horiz line drawing logic places
			# the horiz line, but that's fine.
			var offset_pos_to_corner: Vector2 = Vector2(2, 3)  # Constant
			var screen_pos = pos + offset_pos_to_corner
			var num_interior_horiz_lines = count_x_edge(temp_2)
			_draw_new_interior_horiz_lines(screen_pos, num_interior_horiz_lines)


#    _____
#   |\_____\
#   \|__   |
#	 | *   |
#	  \|___|
func _fix_left_t_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If a block exists below and and to the right
	var temp: Vector3 = map_pos + Vector3(1, 0, -1)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_corner: Vector2 = Vector2(3, 2)  # Constant
			var screen_pos = pos + offset_pos_to_corner
			var num_interior_vert_lines = count_z_edge(temp)
			_draw_new_interior_vert_lines(screen_pos, num_interior_vert_lines)


#	 __________
#	|\   v______\
#	\ \__\______|
#	 \|__|
func _fix_flat_right_t_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If a block exists behind and and to the right
	var temp: Vector3 = map_pos + Vector3(1, -1, 0)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_interior_line: Vector2 = Vector2(5, 1)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_vert_lines = count_x_edge(temp)
			for i in range(num_interior_vert_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_TOP_BAR
				screen_pos.x += 1


#	 ____
#	|\   \
#	|  \___\
#	|>\|___|
#	 \|__|
func _fix_forward_t_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If a block exists behind and and below
	var temp: Vector3 = map_pos + Vector3(0, -1, -1)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_interior_line: Vector2 = Vector2(0, 4)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_vert_lines = count_z_edge(temp)
			# Draw in new interior lines
			for i in range(num_interior_vert_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_RIGHT_BAR
				screen_pos.y += 1


#	 ____
#	|\___\
#	||   |
#	|| v |
#	\ \___\
#	 \|___|
func _fix_forward_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is a block behind and above...
	var temp: Vector3 = map_pos + Vector3(0, -1, 1)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_interior_line: Vector2 = Vector2(2, 1)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_horiz_lines = count_x_edge(temp)
			num_interior_horiz_lines = min(num_interior_horiz_lines, count_x_edge(map_pos))
			# Draw in new interior lines
			for i in range(num_interior_horiz_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_TOP_BAR
				screen_pos.x += 1


#	    ___
#	   |\  \
#	 __|_*  \
#	|\_x_____\
#	\|_______|
# x is current block
# * is the edge we're fixing
func _fix_flat_left_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is a block behind and to the right...
	var temp: Vector3 = map_pos + Vector3(1, -1, 0)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_interior_line: Vector2 = Vector2(3, 0)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_diag_lines = count_y_edge(temp)
			# Draw in new interior lines
			for i in range(num_interior_diag_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG
				screen_pos.x -= 1
				screen_pos.y -= 1

#	    ___
#	   |\  \
#	   | \  *_____
#	    \ \_______\
#	     \|_______|
func _fix_flat_right_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is a block behind and not a block behindand to the right...
	var temp: Vector3 = map_pos + Vector3(1, -1, 0)
	if $Map.is_valid_pos(temp):
		if not $Map.voxel_exists_at_pos(temp) and \
			$Map.is_there_block_behind(map_pos):
			var offset_pos_to_interior_line: Vector2 = Vector2(3, 0)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_diag_lines = count_inner_y_edge(map_pos + Vector3(0, -1, 0))
			# Draw in new interior lines
			for i in range(num_interior_diag_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG
				screen_pos.x -= 1
				screen_pos.y -= 1


#	 _______
#	|\______\
#	||   ____|
#	||  ^
#	||  |
#	\|__|
func _fix_right_t_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is not a block below and to the right.
	var temp: Vector3 = map_pos + Vector3(1, 0, -1)
	if $Map.is_valid_pos(temp):
		if not $Map.voxel_exists_at_pos(temp):
			var offset_pos_to_interior_line: Vector2 = Vector2(4, 5)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			screen_buffer[screen_pos.y][screen_pos.x] = CHAR_RIGHT_BAR


#	   ___
#	 _|\__\
#	|*||  |
#	 \ |  |
# 	  \|__|
func _fix_backwards_l_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is not a block behind and there is a block behind and below...
	var temp: Vector3 = map_pos + Vector3(0, -1, -1)
	if $Map.is_valid_pos(temp):
		if $Map.voxel_exists_at_pos(temp) and \
			not $Map.is_there_block_behind(map_pos):
			var offset_pos_to_interior_line: Vector2 = Vector2(-1, 2)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			var num_interior_diag_lines = count_y_edge(temp) - 1
			if num_interior_diag_lines > 0:
				# Draw in new interior lines
				for i in range(num_interior_diag_lines):
					screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG
					screen_pos.x -= 1
					screen_pos.y -= 1

#	 __
#	|\  \
#	\ \__\
#	 *| x|
#	 *|  |
#	 \|__|
# add to cases where we're adding top and in front (2 cases)
func _fix_backwards_t_corner(pos: Vector2, map_pos: Vector3) -> void:
	# If there is not a block behind and below...
	var temp: Vector3 = map_pos + Vector3(0, -1, -1)
	if $Map.is_valid_pos(temp):
		if not $Map.voxel_exists_at_pos(temp):
			# var offset_pos_to_interior_line: Vector2 = Vector2(-1, 2)  # Constant
			# var screen_pos = pos + offset_pos_to_interior_line
			# var num_interior_diag_lines = count_y_edge(temp) - 1
			# if num_interior_diag_lines > 0:
			# 	# Draw in new interior lines
			# 	for i in range(num_interior_diag_lines):
			# 		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG
			# 		screen_pos.x -= 1
			# 		screen_pos.y -= 1

			# Just draw two small lines manually lol
			var offset_pos_to_interior_line: Vector2 = Vector2(0, 3)  # Constant
			var screen_pos = pos + offset_pos_to_interior_line
			screen_buffer[screen_pos.y][screen_pos.x] = CHAR_DIAG

			var temp_2: Vector3 = map_pos + Vector3(0, 0, -1)
			var num_interior_vert_lines: int = count_z_edge(temp_2) - 1
			offset_pos_to_interior_line = Vector2(0, 4)
			screen_pos = pos + offset_pos_to_interior_line
			for i in range(num_interior_vert_lines):
				screen_buffer[screen_pos.y][screen_pos.x] = CHAR_RIGHT_BAR
				screen_pos.y += 1


# drew the wrong corner...
#  ______
# |\   __\
# \ \  \_|
#  \ \__\
#   \|__|


func count_y_edge(map_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the y direction starting at
	map_pos. This function assumes there are no blocks in FRONT of map_pos.
	Notes: y defined the back to front dimension.
	"""
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = map_pos
	while not found_new_plane:
		if not $Map.voxel_exists_at_pos(cur_pos):
			break

		found_new_plane = found_new_plane or $Map.is_there_block_above(cur_pos)
		found_new_plane = found_new_plane or $Map.is_there_block_left(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.y -= 1

		if not $Map.is_valid_pos(cur_pos):
			break

	return edge_len


func count_inner_y_edge(map_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the y direction starting at
	map_pos. This function assumes there are no blocks in FRONT of map_pos.
	The inner edge is defined as the edge further away from the camera.
	Notes: y defined the back to front dimension.
	"""
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = map_pos
	while not found_new_plane:
		if not $Map.voxel_exists_at_pos(cur_pos):
			break

		found_new_plane = found_new_plane or $Map.is_there_block_above(cur_pos)
		found_new_plane = found_new_plane or $Map.is_there_block_right(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.y -= 1

		if not $Map.is_valid_pos(cur_pos):
			break

	return edge_len



func count_x_edge(map_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the x direction starting at
	map_pos. This function assumes there are no blocks to the left of map_pos.
	Notes: x defined the left to right dimension.
	"""
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = map_pos
	while not found_new_plane:
		if not $Map.voxel_exists_at_pos(cur_pos):
			break

		found_new_plane = found_new_plane or $Map.is_there_block_above(cur_pos)
		found_new_plane = found_new_plane or $Map.is_there_block_infront(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.x += 1

		if not $Map.is_valid_pos(cur_pos):
			break

	return edge_len


func count_z_edge(map_pos: Vector3) -> int:
	"""
	Returns the number of continous blocks in the z direction starting at
	map_pos. This function assumes there are no blocks above map_pos.
	Notes: z defined the up to down dimension.
	"""
	var edge_len = 0
	var found_new_plane = false
	var cur_pos = map_pos
	while not found_new_plane:
		if not $Map.voxel_exists_at_pos(cur_pos):
			break

		found_new_plane = found_new_plane or $Map.is_there_block_left(cur_pos)
		found_new_plane = found_new_plane or $Map.is_there_block_infront(cur_pos)
		if found_new_plane:
			break
		else:
			edge_len += 1
			cur_pos.z -= 1

		if not $Map.is_valid_pos(cur_pos):
			break

	return edge_len


func draw_map(map: Array, bottom_right_voxel_screen_pos: Vector2) -> bool:
	"""
	Draws the entire map to the screen.
	"""
	var cur_pos: Vector2 = bottom_right_voxel_screen_pos # back most row.

	# Traverse back to front
	for y in range($Map.get_map_len_y()):
		cur_pos.y = bottom_right_voxel_screen_pos.y + y
		cur_pos.x = bottom_right_voxel_screen_pos.x + y
		var original_x = cur_pos.x
		# Traverse bottom to top
		for z in range($Map.get_map_len_z()):
			cur_pos.x = original_x
			# Traverse from right to left
			for x in range($Map.get_map_len_x() - 1, -1, -1):
				var map_pos: Vector3 = Vector3(x, y, z)
				if $Map.voxel_exists_at_pos(map_pos):
					if not $Map.is_there_block_behind(map_pos):
						if not $Map.is_there_block_right(map_pos) and \
							not $Map.is_there_block_below(map_pos):
							draw_1x1_voxel(cur_pos)
						elif not $Map.is_there_block_right(map_pos) and \
							$Map.is_there_block_below(map_pos):
							_add_voxel_top(cur_pos, map_pos)
						elif $Map.is_there_block_right(map_pos) and \
							not $Map.is_there_block_below(map_pos):
							_add_voxel_left(cur_pos, map_pos)
						else:
							_add_voxel_top_left(cur_pos, map_pos)
					else:
						# Draw y dimension stuff!
						if not $Map.is_there_block_right(map_pos) and \
							not $Map.is_there_block_below(map_pos):
							_add_voxel_infront(cur_pos, map_pos)
						elif not $Map.is_there_block_right(map_pos) and \
							$Map.is_there_block_below(map_pos):
							_add_voxel_infront_and_top(cur_pos, map_pos)
						elif $Map.is_there_block_right(map_pos) and \
							not $Map.is_there_block_below(map_pos):
							_add_voxel_infront_and_left(cur_pos, map_pos)
						else:
							_add_voxel_infront_and_left_top(cur_pos, map_pos)

				cur_pos.x -= VOXEL_WIDTH
			cur_pos.y -= VOXEL_HEIGHT

	return true

