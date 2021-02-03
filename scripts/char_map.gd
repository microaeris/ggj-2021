extends Control

## Constants

const VOXEL_WIDTH: int = 3
const VOXEL_DEPTH: int = 1
const VOXEL_HEIGHT: int = 3

## Locals

# 3D array that is larger than the voxel map.
# Each position in the voxel map maps to 3x2x3 positions 
# Each position holds an GameState.Object_t. 
var char_map: Array = []
var CHAR_MAP_WIDTH: int = 0 
var CHAR_MAP_DEPTH: int = 0 
var CHAR_MAP_HEIGHT: int = 0 

## Builtin Callbacks

func _ready():
	pass

	
##

func set_char_map_size() -> void:  
	"""
	This depends on the map to be loaded.
	"""
	CHAR_MAP_WIDTH = $"../Map".get_map_len_x() * VOXEL_WIDTH
	CHAR_MAP_DEPTH = $"../Map".get_map_len_y() * VOXEL_DEPTH
	CHAR_MAP_HEIGHT = $"../Map".get_map_len_z() * VOXEL_HEIGHT


func clear_char_map() -> void:
	"""
	Set all points as void. 
	"""
	assert(CHAR_MAP_WIDTH != 0)
	assert(CHAR_MAP_HEIGHT != 0)
	assert(CHAR_MAP_DEPTH != 0)

	char_map = []
	for z in range(CHAR_MAP_HEIGHT):
		var layer = []
		for y in range(CHAR_MAP_DEPTH):
			var row = [null]
			row.resize(CHAR_MAP_WIDTH)
			layer.append(row)
		char_map.append(layer)


func is_valid_pos(pos: Vector3) -> bool:
	return (pos.z >= 0) and (pos.z < len(char_map)) and \
		(pos.y >= 0) and (pos.y < len(char_map[0])) and \
		(pos.x >=  0) and (pos.x < len(char_map[0][0]))


func get_element(pos: Vector3) -> int:
	if is_valid_pos(pos):
		return char_map[pos.z][pos.y][pos.x]
	return GameState.Object_t.OBJECT_NONE


func is_valid_object_type(value: int) -> bool:
	return value < GameState.Object_t.OBJECT_MAX


# Can overwrite any existing elements without warning.
func set_element(pos: Vector3, value: int) -> bool:
	if not is_valid_pos(pos):
		return false
	
	if not is_valid_object_type(value):
		return false
	
	if value == GameState.Object_t.OBJECT_NONE:
		char_map[pos.z][pos.y][pos.x] = null
	else:
		char_map[pos.z][pos.y][pos.x] = value
	return true


func convert_to_voxel_map_coords(pos: Vector3) -> Vector3:
	pos.y /= VOXEL_DEPTH
	pos.x /= VOXEL_WIDTH
	pos.z /= VOXEL_HEIGHT
	return pos


func convert_to_char_map_coords(pos: Vector3) -> Vector3:
	pos.y *= VOXEL_DEPTH
	pos.x *= VOXEL_WIDTH
	pos.z *= VOXEL_HEIGHT
	assert(is_valid_pos(pos))
	return pos


func _on_Map_new_map_loaded() -> void:
	set_char_map_size() 
	clear_char_map()
