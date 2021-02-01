extends Control

## Builtin Callbacks

func _ready():
	var map_name = "TestMap1.map"   # TODO(jm) Don't hardcode
	$Renderer/Map.load_map(map_name)
	var pos: Vector2 = Vector2(20, 15)
	$Renderer.clear_screen_buffer()
	$Renderer.draw_map($Renderer/Map.map, pos)
	print($Renderer.hash_screen_buffer())
	$Renderer.update_screen()

##

