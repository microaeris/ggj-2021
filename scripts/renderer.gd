extends Control

## Constants

const SCREEN_CHAR_WIDTH: int  = 40 
const SCREEN_CHAR_HEIGHT: int  = 25

## Locals

onready var Text = $Text


## Builtin Functions

func _ready():
#	var bytes = PoolByteArray()
#	bytes.push_back(0x005f)
#	bytes.push_back(0xe580)
#	bytes.push_back(0x98)
#	bytes.push_back(0x84)
#	var text = bytes.get_string_from_utf8()
#	print(text)
	
	Text.set_text("Hello World \uE580")
