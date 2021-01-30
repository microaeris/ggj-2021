extends Control

## Locals

# Add new test functions to this array
var test_bench = [
	"_test_is_there",
	"_test_is_valid_world_pos",
	"_test_count_y_edge",
	"_test_count_x_edge",
	"_test_count_z_edge",
	"_test_draw_voxel",
]

## Builtin Callbacks

func _ready():
	for test in test_bench:
		assert(call(test), "Test failed: " + test)

##

func _test_is_there() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	  [
		  [0, 1, 1, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	]
	$Renderer.set_world(world)

	var pos: Vector2 = Vector2(32,20)
	var world_pos = Vector3(3, 0, 0)

	assert($Renderer.is_there_block_above(world_pos))
	world_pos.x -= 1
	assert($Renderer.is_there_block_above(world_pos) == false)
	assert($Renderer.is_there_block_below(world_pos) == false)
	world_pos = Vector3(3, 0, 0)
	assert($Renderer.is_there_block_below(world_pos) == false)
	world_pos.z += 1
	assert($Renderer.is_there_block_below(world_pos) == true)
	world_pos = Vector3(0, 0, 1)
	assert($Renderer.is_there_block_below(world_pos) == false)
	world_pos = Vector3(1, 0, 0)
	assert($Renderer.is_there_block_left(world_pos) == false)
	world_pos = Vector3(2, 0, 0)
	assert($Renderer.is_there_block_left(world_pos) == true)
	world_pos = Vector3(1, 0, 0)
	assert($Renderer.is_there_block_right(world_pos) == true)
	world_pos = Vector3(1, 0, 1)
	assert($Renderer.is_there_block_right(world_pos) == false)
	world_pos = Vector3(0, 1, 0)
	assert($Renderer.is_there_block_infront(world_pos) == true)
	world_pos = Vector3(0, 0, 1)
	assert($Renderer.is_there_block_infront(world_pos) == false)
	world_pos = Vector3(0, 2, 0)
	assert($Renderer.is_there_block_behind(world_pos) == true)
	world_pos = Vector3(0, 1, 0)
	assert($Renderer.is_there_block_behind(world_pos) == false)
	return true


func _test_is_valid_world_pos() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	  [
		  [0, 1, 1, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	]
	$Renderer.set_world(world)

	assert($Renderer.is_valid_world_pos(Vector3(0, 0, 0)) == true)
	assert($Renderer.is_valid_world_pos(Vector3(1, 2, 1)) == true)
	assert($Renderer.is_valid_world_pos(Vector3(3, 3, 2)) == true)
	assert($Renderer.is_valid_world_pos(Vector3(4, 3, 1)) == false)
	assert($Renderer.is_valid_world_pos(Vector3(3, 4, 1)) == false)
	assert($Renderer.is_valid_world_pos(Vector3(3, 3, 3)) == false)
	assert($Renderer.is_valid_world_pos(Vector3(-1, 3, 1)) == false)
	return true


func _test_count_y_edge() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	  [
		  [0, 1, 1, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	]
	$Renderer.set_world(world)

	assert($Renderer.count_y_edge(Vector3(0, 3, 0)) == 3, "Expected 3, was " + str($Renderer.count_y_edge(Vector3(0, 3, 0))))
	var test_pos = Vector3(3, 0, 2)
	assert($Renderer.count_y_edge(test_pos) == 1, "Expected 1, was " + str($Renderer.count_y_edge(test_pos)))
	test_pos = Vector3(3, 3, 0)
	var expected = 3
	assert($Renderer.count_y_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str($Renderer.count_y_edge(test_pos)))
	test_pos = Vector3(3, 0, 0)
	expected = 0
	assert($Renderer.count_y_edge(test_pos) == expected, "Expected " + str(expected) + ", was " + str($Renderer.count_y_edge(test_pos)))
	return true


func _test_count_x_edge() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	  [
		  [0, 1, 1, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	]
	$Renderer.set_world(world)

	# Tests x edge
	var test_pos = Vector3(0, 3, 0)
	var expected = 2
	var result = $Renderer.count_x_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	test_pos = Vector3(3, 0, 2)
	expected = 1
	result = $Renderer.count_x_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	test_pos = Vector3(3, 0, 0)
	expected = 0
	result = $Renderer.count_x_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	return true


func _test_count_z_edge() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
	  [
		  [0, 1, 1, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
		  [1, 1, 0, 1],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	  [
		  [0, 0, 0, 1],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
		  [0, 0, 0, 0],
	  ],
	]
	$Renderer.set_world(world)

	# Tests z edge
	var test_pos = Vector3(3, 0, 2)
	var expected = 2
	var result = $Renderer.count_z_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	test_pos = Vector3(1, 3, 0)
	expected = 0
	result = $Renderer.count_z_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	test_pos = Vector3(0, 3, 0)
	expected = 1
	result = $Renderer.count_z_edge(test_pos)
	assert(result == expected, "Expected " + str(expected) + ", was " + str(result))
	return true


func _test_draw_voxel() -> bool:
	var expected_screen_hash: String = "e0f2bb1834782d4a446dc05b039c1b8a99d8e0d7"
	var pos: Vector2 = Vector2(32,15)
	$Renderer.clear_screen_buffer()
	$Renderer.draw_1x1_voxel(pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
#	yield($Renderer.print_screen_buffer(), "completed")
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)
	return true

