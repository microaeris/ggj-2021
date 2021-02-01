extends Control

## Builtin Callbacks

func _ready():
	var map_name = "TestMap1.map"   # TODO(jm) Don't hardcode
	$Renderer/Map.load_map(map_name)
	$Renderer.clear_screen_buffer()
	$Renderer.set_camera_center($Renderer/Map.get_center_pos())
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

