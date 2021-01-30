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

## Locals

onready var Text = $Text
var screen_buffer: Array = []  # 2D Array of strings to write to the text box

## Builtin Functions

func _ready():
	_clear_screen_buffer()
	var pos: Vector2 = Vector2(32,20)
	_draw_1x1_voxel(pos)
	_draw_row(5, pos)
	
	_draw_col(5, pos)
	_update_screen()

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


func _draw_row(num_voxels: int, pos: Vector2) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.
	
	for i in range(num_voxels):
		pos.x -= VOXEL_WIDTH
		_add_voxel_left(pos)
	return true


func _draw_col(num_voxels: int, pos: Vector2) -> bool:
	"""
	Assumes we're appending onto existing voxels
	Args
		num_voxels: number of voxels to draw in a row.
		pos: position of existing voxel we're appending to in the screen_buffer.
	"""
	# FIXME - handle draw calls that end outside of screen buffer or start outside of screen buffer.
	
	for i in range(num_voxels):
		pos.y -= VOXEL_HEIGHT
		_add_voxel_top(pos)
	return true


func _add_voxel_left(pos:Vector2) -> bool:
	"""
	Draws a new voxel to the left assuming this voxel is the bottom layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
	"""
#   # Check if the voxel to our left matches the shape we expect...
#   var pos_right: Vector2 = pos + Vector2(3, 0)
#   if not _check_screen_buffer_equal(VOXEL_ADD_LEFT, pos_right):
#       return false
	# FIXME - need to create the array to represent the left part of a 1x1 cube.
	
	_copy_into_screen_buffer(VOXEL_ADD_LEFT, pos)
	
	# Count the current length of interior line and erase them.
	var num_interior_horiz_lines = 0
	var offset_pos_to_old_interior_horiz_line: Vector2 = Vector2(6, 2)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_horiz_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_TOP_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		num_interior_horiz_lines += 1
		screen_pos.x += 1
	
	# Draw new interior lines. Should draw two more than old value. 
	num_interior_horiz_lines += 1
	print(num_interior_horiz_lines)
	var offset_pos_to_interior_horiz_line: Vector2 = Vector2(3, 2)  # Constant
	screen_pos = pos + offset_pos_to_interior_horiz_line
	for i in range(num_interior_horiz_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_TOP_BAR
		screen_pos.x += 1

	return true


func _add_voxel_top(pos:Vector2) -> bool:
	"""
	Draws a new voxel on top of an existing voxel. Assumes new voxel to be added
	is the top most layer.
	Increases the interior line length and moves it over.
	Args
		pos: position in screen buffer to draw the new voxel.
	"""
	# FIXME - need to create the array to represent the left part of a 1x1 cube.
	
	_copy_into_screen_buffer(VOXEL_ADD_TOP, pos) 

	# Count the current length of interior line and erase them.
	var num_interior_vert_lines = 0
	var offset_pos_to_old_interior_vert_line: Vector2 = Vector2(2, 6)  # Constant
	var screen_pos: Vector2 = pos + offset_pos_to_old_interior_vert_line
	while (screen_buffer[screen_pos.y][screen_pos.x] == CHAR_LEFT_BAR):
		screen_buffer[screen_pos.y][screen_pos.x] = " "
		num_interior_vert_lines += 1
		screen_pos.y += 1
	
	# Draw new interior lines. Should draw two more than old value. 
	num_interior_vert_lines += 1
	var offset_pos_to_interior_vert_line: Vector2 = Vector2(2, 3)  # Constant
	screen_pos = pos + offset_pos_to_interior_vert_line
	for i in range(num_interior_vert_lines):
		screen_buffer[screen_pos.y][screen_pos.x] = CHAR_LEFT_BAR
		screen_pos.y += 1

	return true
