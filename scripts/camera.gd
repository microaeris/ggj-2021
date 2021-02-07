extends Control

## Locals

# The voxel that is in the center of the screen
var _camera_center_voxel_map_coords: Vector3 = Vector3(0,0,0)
onready var map_node = $"../Map"


## Builtin Callbacks

func _ready():
	pass

##

func set_camera_center(pos: Vector3) -> void:
	assert(map_node.is_valid_pos(pos))
	_camera_center_voxel_map_coords = pos


func get_camera_center() -> Vector3:
	return _camera_center_voxel_map_coords
