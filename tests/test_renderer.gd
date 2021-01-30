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
	"_test_draw_row",
	"_test_draw_col",
	"_test_draw_left_l",
	"_test_draw_right_l",
    "_test_draw_u",
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


func _test_draw_row() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[1, 1, 1, 1],
		],
	]
	$Renderer.set_world(world)

	var expected_screen_hash: String = "4bc3e2880a6f5078f8a9074fb9179fa01bfdc194"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var world_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(3, pos, world_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	world = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[0, 0, 1, 1],
		],
	]
	$Renderer.set_world(world)

	expected_screen_hash = "3006254908a43d96988a0ce28000408440080655"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	world = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[1, 1, 1, 1, 1, 1],
		],
	]
	$Renderer.set_world(world)

	expected_screen_hash = "c2bcc3be642fb559178e09e309be41437f92f5de"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_col() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 1],
		],
	]
	$Renderer.set_world(world)

	var expected_screen_hash: String = "09c3f451098b8a7cdce27af7f2356ddeec5abfa3"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var world_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(5, pos, world_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "3700ef3b4cf5325fb7aaf52a49454e77b8c84b6b"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(1, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "de8509d9e6ce4073e4fbe67df16093fad7b90072"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(2, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_left_l() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [1, 1, 1, 1, 1, 1],
		],
		[
		  [0, 0, 0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 0, 0, 1],
		],
		[
		  [0, 0, 0, 0, 0, 1],
		],
	]
	$Renderer.set_world(world)

	var expected_screen_hash: String = "d3d0c3a5146ac74a679d4505896904efb84ee06f"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var world_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, world_pos)
	$Renderer.draw_col(5, pos, world_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "35b3fd6a5378115ea2867dbd4a4ae389f27422d0"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(3, pos, world_pos)
	$Renderer.draw_col(2, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)


	##

	expected_screen_hash = "4f6dc8c72c64612ae27e71310a32891597be7d59"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, world_pos)
	$Renderer.draw_col(1, pos, world_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_right_l() -> bool:
	var world: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [1, 1, 1, 1, 1, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
	]
	$Renderer.set_world(world)

	var expected_screen_hash: String = "5493b178cf2a5ee75989aecd890f44b12b176647"

	var pos: Vector2 = Vector2(32,15)
	var world_pos = Vector3(5, 0, 0)
	$Renderer.clear_screen_buffer()
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, world_pos)

	pos = Vector2(17,15)
	world_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(5, pos, world_pos)

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	world = [
		[
		  [1, 1, 0, 1, 1, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
		[
		  [1, 0, 0, 0, 0, 1],
		],
	]
	$Renderer.set_world(world)

	expected_screen_hash = "d1addce493152ab5d130c466b5756c6104336c3d"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	world_pos = Vector3(1, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, world_pos)

	pos = Vector2(29,15)
	world_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(1, pos, world_pos)

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_u() -> bool:
    return true