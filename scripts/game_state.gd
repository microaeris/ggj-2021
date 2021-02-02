extends Node

## Locals

enum Object_t {
	OBJECT_NONE,
	OBJECT_PLAYER,
	OBJECT_FLAG,
	OBJECT_MAX,
}

var Object_char: Dictionary = {
	Object_t.OBJECT_PLAYER: "\ue200",  # @
	Object_t.OBJECT_FLAG: "\ue158",  # Clover
}



func _ready():
	pass 
	
