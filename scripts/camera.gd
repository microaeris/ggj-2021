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
var window_margin_left: int = 24
var window_margin_right: int = 24
var window_margin_top: int = 15
var window_margin_bottom: int = 15

## Locals

# The voxel that is in the center of the screen
var _camera_center_char_map_coords: Vector3 = Vector3(0,0,0)
onready var map_node = $"../Map"
onready var char_map_node = $"../CharMap"
onready var player_node = $"../../Player"
onready var renderer_node = $"../../Renderer"

## Builtin Callbacks

func _ready():
	pass

##

func set_camera_center(pos: Vector3) -> void:
	assert(char_map_node.is_valid_pos(pos))
	_camera_center_char_map_coords = pos


func get_camera_center() -> Vector3:
	return _camera_center_char_map_coords


func update_camera_position() -> void:
	"""
	Update the camera's position based on the player's current position.
	If the player's screen coords are outside the camera window, then
	shift the camera as appropriate.
	"""
	var screen_pos: Vector2 = renderer_node.char_map_space_to_screen_space(player_node.get_pos())
	var cam_pos: Vector3 = _camera_center_char_map_coords

	if screen_pos.x < window_margin_left:
		cam_pos.x -= 1  # Move the camera over by 1 entire voxel. This will jump the camera a little....
		cam_pos.x = max(cam_pos.x, 0)
	elif screen_pos.x >= (renderer_node.SCREEN_CHAR_WIDTH - window_margin_right):
		cam_pos.x += 1
		cam_pos.x = min(cam_pos.x, char_map_node.get_map_len_x() - 1)

	if screen_pos.y < window_margin_top:
		cam_pos.z += 1
		cam_pos.z = min(cam_pos.z, char_map_node.get_map_len_z() - 1)
	elif screen_pos.y >= (renderer_node.SCREEN_CHAR_HEIGHT - window_margin_bottom):
		cam_pos.z -= 1
		cam_pos.z = max(cam_pos.z, 0)

	set_camera_center(cam_pos)
