extends Control

## Notes

# Each block has 3 spaces wide for players to stand and two blocks deep.

## Locals

var player_pos: Vector3 = Vector3(0,0,0)  # In char map coords
var player_grabbing: bool = false
var player_jumping: bool = true

onready var map_node = $"../Renderer/Map"
onready var renderer_node = $"../Renderer"


## Builtin Callbacks

func _ready():
	set_process_input(true)


func _process(delta):
	# TODO Animate jump
	pass 


func _input(event):
	var handled: bool = false
	var new_pos: Vector3 = player_pos
	
	if event.is_action_pressed("ui_up"):
		handled = true
		new_pos.y -= 1
	elif event.is_action_pressed("ui_down"):
		handled = true
		new_pos.y += 1
	elif event.is_action_pressed("ui_left"):
		handled = true
		new_pos.x -= 1
	elif event.is_action_pressed("ui_right"):
		handled = true
		new_pos.x += 1
	elif event.is_action_pressed("grab"):
		handled = true
		if not player_jumping:
			player_grabbing = true
	elif event.is_action_released("grab"):
		handled = true
		player_grabbing = false
	elif event.is_action_pressed("jump"):
		handled = true
		if not player_grabbing:
			player_jumping = true
	
	if handled:
		get_tree().set_input_as_handled()
		player_pos = calc_player_map_collision(new_pos)
		draw_player()


##

func calc_player_map_collision(new_pos: Vector3) -> Vector3:
	"""
	Returns the actual position the player will be after trying to move to new_pos.
	"""
	# Can't move the player off the screen
	if not map_node.is_valid_pos(new_pos):
		return player_pos
	
	# Can't move the player into a voxel. Sorry fam you can't pass through walls.
	if map_node.voxel_exists_at_pos(new_pos):
		return player_pos
	
	return new_pos
	# FIXME - idkkK!!


func draw_player():
	# Cannot jump and grab at the same time
	assert(player_jumping != player_grabbing)

	if player_jumping:
		pass
	elif player_grabbing:
		pass
	else:
		pass
