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


## Builtin Functions

func _ready():
	var test = CHAR_AT_INV + CHAR_AT + CHAR_UP_ARROW \
		+CHAR_BOT_BAR+CHAR_TOP_BAR+CHAR_LEFT_BAR+CHAR_RIGHT_BAR+CHAR_DIAG+CHAR_ASTERICKS+CHAR_EXCLAMATION+CHAR_QUESTION+CHAR_DIAG_STRIPES \
		+CHAR_X+ CHAR_HALF_DITHER+CHAR_HEART+CHAR_CIRCLE+CHAR_FILLED_CIRCLE+CHAR_DIAMOND
	Text.set_text(test)
