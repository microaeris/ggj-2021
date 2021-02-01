extends Control

## Builtin Callbacks

func _ready():
	var map_name = "TestMap1.map"   # TODO(jm) Don't hardcode
	$Renderer/Map.load_map(map_name)
	$Renderer.clear_screen_buffer()
	$Renderer.set_camera_center($Map.get_center_pos())
	$Renderer.draw_map()
	print($Renderer.hash_screen_buffer())
	$Renderer.update_screen()

func _input(event):
	if event.is_action_pressed("ui_accept"):
		$Player.show()
		$Renderer.show()
		$HUD.show()
		$TitleScreen.hide()

##

