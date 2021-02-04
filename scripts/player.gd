extends Control

## Notes

# Each block has 3 spaces wide for players to stand and two blocks deep.

## Consts

const BUTTON_WAIT_MS: float = .25
const MAX_JUMP_HEIGHT: int = 4
# Time between vertical movements
const VERT_MOVE_WAIT_MS: float = .5

## Locals

var player_pos: Vector3 = Vector3(0,0,0)  # In char map coords
var player_grabbing: bool = false
var player_jumping: bool = false
var player_falling: bool = false
var up_pressed: bool = false
var down_pressed: bool = false
var left_pressed: bool = false
var right_pressed: bool = false

var wasd_press_delta: float = 0.0
var vert_move_delta: float = 0.0
var player_cur_jump_height: float = 0.0
var vertical_velocity: float = 0.0
var vertical_acceleration: float = 0.0

onready var char_map_node = $"../Renderer/CharMap"
onready var map_node = $"../Renderer/Map"
onready var renderer_node = $"../Renderer"


## Builtin Callbacks

func _ready():
	set_process_input(true)


func _process(delta):
	var old_pos: Vector3 = player_pos
	handle_jump_and_fall(false, delta)

	if up_pressed or down_pressed or left_pressed or right_pressed:
		wasd_press_delta += delta
		if wasd_press_delta >= BUTTON_WAIT_MS:
			wasd_press_delta -= BUTTON_WAIT_MS
			wasd_press_delta = max(0, wasd_press_delta)
			handle_wasd_input()

	handle_player_moved(old_pos)  # Draws screen and stuff


func _input(event):
	var handled: bool = false
	var old_pos: Vector3 = player_pos

	if event.is_action_pressed("ui_up"):
		up_pressed = true
		handled = true
	elif event.is_action_released("ui_up"):
		up_pressed = false
		handled = true
		wasd_press_delta = 0.0
	elif event.is_action_pressed("ui_down"):
		down_pressed = true
		handled = true
	elif event.is_action_released("ui_down"):
		down_pressed = false
		handled = true
		wasd_press_delta = 0.0
	elif event.is_action_pressed("ui_left"):
		left_pressed = true
		handled = true
	elif event.is_action_released("ui_left"):
		left_pressed = false
		handled = true
		wasd_press_delta = 0.0
	elif event.is_action_pressed("ui_right"):
		right_pressed = true
		handled = true
	elif event.is_action_released("ui_right"):
		right_pressed = false
		handled = true
		wasd_press_delta = 0.0
	elif event.is_action_pressed("grab"):
		handled = true
		if not player_jumping and not player_falling:
			player_grabbing = true
	elif event.is_action_released("grab"):
		handled = true
		player_grabbing = false
		wasd_press_delta = 0.0
	elif event.is_action_pressed("jump"):
		handled = true
		# This line prevents double jumping and chaining jumps.
		if not player_grabbing and not player_jumping and not player_falling:
			player_jumping = true
			handle_jump_and_fall(true)

	if handled:
		get_tree().set_input_as_handled()
		handle_wasd_input()
		handle_player_moved(old_pos)


##


func handle_player_moved(old_pos: Vector3):
	if old_pos != player_pos:
		renderer_node.clear_screen_buffer()
		renderer_node.draw_map()
		renderer_node.update_screen()


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
	set_pos(calc_player_map_collision(new_pos))


func handle_jump_and_fall(start_new_jump: bool, delta: float = 0) -> void:
	var new_pos: Vector3 = player_pos
	if start_new_jump:
		player_cur_jump_height = 1
		new_pos.z += 1
	elif player_jumping:
		vert_move_delta += delta
		# Add a delay between frames
		if vert_move_delta >= VERT_MOVE_WAIT_MS:
			vert_move_delta = max(0, vert_move_delta - VERT_MOVE_WAIT_MS)
			if player_cur_jump_height < MAX_JUMP_HEIGHT:
				player_cur_jump_height += 1
				new_pos.z += 1
			elif player_cur_jump_height == MAX_JUMP_HEIGHT:
				player_jumping = false
				player_falling = true
				player_cur_jump_height = 0
				# Pause at top frame for 1 tick, so don't do `new_pos.z -= 1`.
	elif player_falling:
		vert_move_delta += delta
		# Add a delay between frames
		if vert_move_delta >= VERT_MOVE_WAIT_MS:
			vert_move_delta = max(0, vert_move_delta - VERT_MOVE_WAIT_MS)
			new_pos.z -= 1

	if calc_player_map_collision(new_pos) == new_pos:
		set_pos(new_pos)
	else:
		# Collided with map and so now player is done falling.
		player_falling = false
		vert_move_delta = 0.0


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

	# Check if player is now falling
	if not map_node.is_there_voxel_below(map_pos) and map_pos.z > 0:
		player_falling = true

	return new_pos
