extends Control

## Notes

#                            window_margin_top
#
#                    +----------------+-----------------+
#                    |                |                 |
#                    |                |                 |
#                    |     +----------+-----------+     |
#                    |     |                      |     |
#                    |     |       CAMERA         |     |
# window_margin_left +-----+       WINDOW         +-----+ window_margin_right
#                    |     |                      |     |
#                    |     |                      |     |
#                    |     +----------+-----------+     |
#                    |                |                 |
#                    |                |                 |
#                    +----------------+-----------------+
#
#                              window_margin_bottom

## Constants

# FIXME - make these a function of screen size... Refactor window size to live in GameState.
# Units: screen space
var window_margin_left: int = 20
var window_margin_right: int = 20
var window_margin_top: int = 20
var window_margin_bottom: int = 20

## Locals

# The voxel that is in the center of the screen
var _camera_center_voxel_map_coords: Vector3 = Vector3(0,0,0)
onready var map_node = $"../Map"
onready var player_node = $"../../Player"

## Builtin Callbacks

func _ready():
	pass

##

func set_camera_center(pos: Vector3) -> void:
	assert(map_node.is_valid_pos(pos))
	_camera_center_voxel_map_coords = pos


func get_camera_center() -> Vector3:
	return _camera_center_voxel_map_coords


func update_camera_position() -> void:
	"""
	Update the camera's position based on the player's current position.
	If the player's screen coords are outside the camera window, then
	shift the camera as appropriate.
	"""
	set_camera_center(player_node.get_pos_in_voxel_coords())
