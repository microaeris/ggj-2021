extends Control

## Notes

# Each block has 3 spaces wide for players to stand and two blocks deep.

## Consts

const BUTTON_WAIT_MS: float = .4

## Locals

var player_pos: Vector3 = Vector3(0,0,0)  # In char map coords
var player_grabbing: bool = false
var player_jumping: bool = true
var up_pressed: bool = false
var down_pressed: bool = false
var left_pressed: bool = false
var right_pressed: bool = false
var press_delta: float = 0.0

onready var char_map_node = $"../Renderer/CharMap"
onready var map_node = $"../Renderer/Map"
onready var renderer_node = $"../Renderer"


## Builtin Callbacks

func _ready():
	set_process_input(true)


func _process(delta):
	# TODO Animate jump

	if up_pressed or down_pressed or left_pressed or right_pressed:
		press_delta += delta
		if press_delta > BUTTON_WAIT_MS:
			press_delta -= BUTTON_WAIT_MS
			press_delta = max(0, press_delta)
			handle_wasd_input()


func _input(event):
	var handled: bool = false
	
	if event.is_action_pressed("ui_up"):
		up_pressed = true
		handled = true
	elif event.is_action_released("ui_up"):
		up_pressed = false
		handled = true
		press_delta = 0.0
	elif event.is_action_pressed("ui_down"):
		down_pressed = true
		handled = true
	elif event.is_action_released("ui_down"):
		down_pressed = false
		handled = true
		press_delta = 0.0
	elif event.is_action_pressed("ui_left"):
		left_pressed = true
		handled = true
	elif event.is_action_released("ui_left"):
		left_pressed = false
		handled = true
		press_delta = 0.0
	elif event.is_action_pressed("ui_right"):
		right_pressed = true
		handled = true
	elif event.is_action_released("ui_right"):
		right_pressed = false
		handled = true
		press_delta = 0.0
	elif event.is_action_pressed("grab"):
		handled = true
		if not player_jumping:
			player_grabbing = true
	elif event.is_action_released("grab"):
		handled = true
		player_grabbing = false
		press_delta = 0.0
	elif event.is_action_pressed("jump"):
		handled = true
		if not player_grabbing:
			player_jumping = true
	
	if handled:
		get_tree().set_input_as_handled()
		handle_wasd_input()

##

func handle_wasd_input() -> void:
	var new_pos: Vector3 = player_pos
	if up_pressed:
		new_pos.y -= 1
	elif down_pressed:
		new_pos.y += 1
	elif left_pressed:
		new_pos.x -= 1
	elif right_pressed:
		new_pos.x += 1
	if set_pos(calc_player_map_collision(new_pos)):
		renderer_node.clear_screen_buffer()
		renderer_node.draw_map()
		renderer_node.update_screen()


func set_pos(pos: Vector3) -> bool:
	"""
	Args:
		pos: coordinates in char map space.
		
	"""
	if $"../Renderer/CharMap".is_valid_pos(pos):
		assert($"../Renderer/CharMap".set_element(player_pos, GameState.Object_t.OBJECT_NONE))
		assert($"../Renderer/CharMap".set_element(pos, GameState.Object_t.OBJECT_PLAYER))
		player_pos = pos
		return true
	return false


func calc_player_map_collision(new_pos: Vector3) -> Vector3:
	"""
	Returns the actual position the player will be after trying to move to new_pos.
	"""
	var map_pos: Vector3 = char_map_node.convert_to_voxel_map_coords(new_pos)
	
	# Can't move the player off the screen
	if not map_node.is_valid_pos(map_pos):
		return player_pos
	
	# Can't move the player into a voxel. Sorry fam you can't pass through walls.
	if map_node.voxel_exists_at_pos(map_pos):
		return player_pos
	
	return new_pos
