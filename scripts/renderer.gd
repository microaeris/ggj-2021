extends Control

## Constants

const SCREEN_CHAR_WIDTH: int  = 40 
const SCREEN_CHAR_HEIGHT: int  = 25

const CHAR_AT_INV: String = "\ue680"
const CHAR_AT: String = "\ue600"
const CHAR_UP_ARROW: String = "\ue61e"
const CHAR_CORNER_BOT_LEFT: String = "\ue64c"  # L
const CHAR_CORNER_BOT_RIGHT: String = "\ue650"  # _|  // FIXME
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
const CHAR_HEART: String = "\ue153"
const CHAR_CIRCLE: String = "\ue157"
const CHAR_FILLED_CIRCLE: String = "\ue151"
const CHAR_DIAMOND: String = "\ue15a"

## Locals

onready var Text = $Text
var screen_buffer: Array = []  # 2D Array of strings to write to the text box

## Builtin Functions

func _ready():
	_clear_screen_buffer()
	var test: Array = []
	test.append([CHAR_CORNER_BOT_LEFT, CHAR_FILLED_CIRCLE, CHAR_DIAG])
	test.append([CHAR_ASTERICKS])
	_copy_into_screen_buffer(test, Vector2(10,10))
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
