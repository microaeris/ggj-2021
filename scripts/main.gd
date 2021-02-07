extends Control

## Builtin Callbacks

func _ready():
#	var map_name = "TestMap1.map"   # TODO(jm) Don't hardcode
#	$Renderer/Map.load_map(map_name)
#	$Renderer.clear_screen_buffer()
#	$Renderer.set_camera_center($Renderer/Map.get_center_pos())
#	assert($Player.set_pos($Renderer/CharMap.convert_to_char_map_coords(Vector3(3, 4, 0))))  # TODO(aw) This value works for level 1. Don't hardcode...
#	$Renderer.draw_map()
#	print($Renderer.hash_screen_buffer())
#	$Renderer.update_screen()

	var map_name = "TestMap1.map"   # TODO(jm) Don't hardcode
	$Renderer/Map.load_map(map_name)
	$Renderer.clear_screen_buffer()
	# $Renderer.set_camera_center($Renderer/Map.get_center_pos() + Vector3(0, 5, 0))
	# var player_pos: Vector3 = $Renderer/Map.get_center_pos()
	# player_pos.x *= 1.2
	# player_pos.z = 0
	# assert($Player.set_pos($Renderer/CharMap.convert_to_char_map_coords(player_pos)))  # TODO(aw) This value works for cutout cube. don't hard code!
	$Renderer.draw_map()
	print($Renderer.hash_screen_buffer())
	$Renderer.update_screen()


func _input(event):
	if $TitleScreen.visible:
		if event is InputEventKey:
			# Weird.. The space key isn't registering here. It's a problem with
			# ghosting with my keyboard.
			# https://godotengine.org/qa/20510/spacebar-blocks-input-optimal-movment-code-solution
			if event.is_action_pressed("ui_accept"):
				$Player.show()
				$Renderer.show()
				$TitleScreen.hide()
				get_tree().set_input_as_handled()

##

