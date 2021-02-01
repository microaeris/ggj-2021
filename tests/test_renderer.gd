extends Control

## Locals

# Add new test functions to this array
# I sit here.
var test_bench = [
#	"_test_is_there",
#	"_test_is_valid_map_pos",
#	"_test_count_y_edge",
#	"_test_count_x_edge",
#	"_test_count_z_edge",
#	"_test_draw_voxel",
#	"_test_draw_row",
#	"_test_draw_col",
#	"_test_draw_left_l",
#	"_test_draw_right_l",
#	"_test_draw_u",
#	"_test_draw_donut",
#	"_test_draw_heart",
#	"_test_draw_diag",
#	"_test_voxel_map_space_to_screen_space",
	# "_test_draw_level_1",
	"_test_small_map",
]

## Builtin Callbacks

func _ready():
	for test in test_bench:
		assert(call(test), "Test failed: " + test)
	print("All tests passed.")

##

func _test_is_there() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	var pos: Vector2 = Vector2(32,20)
	var map_pos = Vector3(3, 0, 0)

	assert($Renderer/Map.is_there_voxel_above(map_pos))
	map_pos.x -= 1
	assert($Renderer/Map.is_there_voxel_above(map_pos) == false)
	assert($Renderer/Map.is_there_voxel_below(map_pos) == false)
	map_pos = Vector3(3, 0, 0)
	assert($Renderer/Map.is_there_voxel_below(map_pos) == false)
	map_pos.z += 1
	assert($Renderer/Map.is_there_voxel_below(map_pos) == true)
	map_pos = Vector3(0, 0, 1)
	assert($Renderer/Map.is_there_voxel_below(map_pos) == false)
	map_pos = Vector3(1, 0, 0)
	assert($Renderer/Map.is_there_voxel_left(map_pos) == false)
	map_pos = Vector3(2, 0, 0)
	assert($Renderer/Map.is_there_voxel_left(map_pos) == true)
	map_pos = Vector3(1, 0, 0)
	assert($Renderer/Map.is_there_voxel_right(map_pos) == true)
	map_pos = Vector3(1, 0, 1)
	assert($Renderer/Map.is_there_voxel_right(map_pos) == false)
	map_pos = Vector3(0, 1, 0)
	assert($Renderer/Map.is_there_voxel_infront(map_pos) == true)
	map_pos = Vector3(0, 0, 1)
	assert($Renderer/Map.is_there_voxel_infront(map_pos) == false)
	map_pos = Vector3(0, 2, 0)
	assert($Renderer/Map.is_there_voxel_behind(map_pos) == true)
	map_pos = Vector3(0, 1, 0)
	assert($Renderer/Map.is_there_voxel_behind(map_pos) == false)
	return true


func _test_is_valid_map_pos() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	assert($Renderer/Map.is_valid_pos(Vector3(0, 0, 0)) == true)
	assert($Renderer/Map.is_valid_pos(Vector3(1, 2, 1)) == true)
	assert($Renderer/Map.is_valid_pos(Vector3(3, 3, 2)) == true)
	assert($Renderer/Map.is_valid_pos(Vector3(4, 3, 1)) == false)
	assert($Renderer/Map.is_valid_pos(Vector3(3, 4, 1)) == false)
	assert($Renderer/Map.is_valid_pos(Vector3(3, 3, 3)) == false)
	assert($Renderer/Map.is_valid_pos(Vector3(-1, 3, 1)) == false)
	return true


func _test_count_y_edge() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

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
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

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
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

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
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[1, 1, 1, 1],
		],
	]
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "4bc3e2880a6f5078f8a9074fb9179fa01bfdc194"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var map_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(3, pos, map_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	map = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[0, 0, 1, 1],
		],
	]
	$Renderer/Map.set_map(map)

	expected_screen_hash = "3006254908a43d96988a0ce28000408440080655"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	map = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
			[1, 1, 1, 1, 1, 1],
		],
	]
	$Renderer/Map.set_map(map)

	expected_screen_hash = "c2bcc3be642fb559178e09e309be41437f92f5de"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_col() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "09c3f451098b8a7cdce27af7f2356ddeec5abfa3"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var map_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(5, pos, map_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "3700ef3b4cf5325fb7aaf52a49454e77b8c84b6b"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(1, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "de8509d9e6ce4073e4fbe67df16093fad7b90072"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(3, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_col(2, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_left_l() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "d3d0c3a5146ac74a679d4505896904efb84ee06f"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, map_pos)
	$Renderer.draw_col(5, pos, map_pos)
	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "35b3fd6a5378115ea2867dbd4a4ae389f27422d0"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(3, pos, map_pos)
	$Renderer.draw_col(2, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)


	##

	expected_screen_hash = "4f6dc8c72c64612ae27e71310a32891597be7d59"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, map_pos)
	$Renderer.draw_col(1, pos, map_pos)
	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_right_l() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "5493b178cf2a5ee75989aecd890f44b12b176647"

	var pos: Vector2 = Vector2(32,15)
	var map_pos = Vector3(5, 0, 0)
	$Renderer.clear_screen_buffer()
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, map_pos)

	pos = Vector2(17,15)
	map_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(5, pos, map_pos)

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	map = [
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
	$Renderer/Map.set_map(map)

	expected_screen_hash = "d1addce493152ab5d130c466b5756c6104336c3d"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(1, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(1, pos, map_pos)

	pos = Vector2(29,15)
	map_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(1, pos, map_pos)

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_u() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "7ee31e2c6a008c860a2652c3e91cb93b671edc7c"

	$Renderer.clear_screen_buffer()
	var pos: Vector2 = Vector2(32,15)
	var map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, map_pos)
	$Renderer.draw_col(5, pos, map_pos)

	pos = Vector2(17,15)
	map_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(5, pos, map_pos)

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "928d0718a3c4128dd48eeb5a36b9ec9316e9927d"

	$Renderer.clear_screen_buffer()
	pos = Vector2(32,15)
	map_pos = Vector3(5, 0, 0)
	$Renderer.draw_1x1_voxel(pos)
	$Renderer.draw_row(5, pos, map_pos)
	$Renderer.draw_col(1, pos, map_pos)

	pos = Vector2(17,15)
	map_pos = Vector3(0, 0, 0)
	$Renderer.draw_col(1, pos, map_pos)

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_draw_donut() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
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
		  [1, 1, 1, 1, 1, 1],
		],
	]
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "ae3ca1e382996db3d6c3f4f355e7fa8be7bd7a74"

	$Renderer.clear_screen_buffer()
	$Renderer.draw_map()

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)
	# $Renderer.update_screen()

	return true


func _test_draw_heart() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [0, 0, 1, 0, 0, 0],
		],
		[
		  [0, 1, 1, 1, 0, 0],
		],
		[
		  [1, 1, 1, 1, 1, 0],
		],
		[
		  [1, 1, 0, 1, 1, 0],
		],
	]
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "a958304aa0e2c90a62c0dea4cb613c1bd2fa1e63"

	$Renderer.clear_screen_buffer()
	$Renderer.draw_map()

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)
	# $Renderer.update_screen()

	return true


func _test_draw_diag() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		  [0, 0, 1, 0, 0, 0],
		],
	]
	$Renderer/Map.set_map(map)

	var expected_screen_hash: String = "96f1d94c3af074e77a97befcfda742120fc860dd"
	var pos: Vector2 = Vector2(15, 10)
	$Renderer.clear_screen_buffer()
	$Renderer.draw_1x1_voxel(pos)
	pos += Vector2(1, 1)
	$Renderer._add_voxel_infront(pos, Vector3(2, 1, 0))

	var resulting_hash: String = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "0b1e18424892bf04a217b4e8ea7e480643640204"
	pos += Vector2(1, 1)
	$Renderer._add_voxel_infront(pos, Vector3(2, 2, 0))

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "6a02789f7011b86c28d94e1608ce4f7726a06983"
	pos += Vector2(1, 1)
	$Renderer._add_voxel_infront(pos, Vector3(2, 3, 0))

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "414276560cbbf32ae571df661f2aeac6f4757906"
	pos += Vector2(1, 1)
	$Renderer._add_voxel_infront(pos, Vector3(2, 4, 0))

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	##

	expected_screen_hash = "fb4ed23be51c5f1b3c335bc496289c5b9d53e5b7"
	pos += Vector2(1, 1)
	$Renderer._add_voxel_infront(pos, Vector3(2, 5, 0))

	resulting_hash = $Renderer.hash_screen_buffer()
	assert(expected_screen_hash == resulting_hash, "Expected: " + expected_screen_hash + ". Actual: " + resulting_hash)

	return true


func _test_voxel_map_space_to_screen_space() -> bool:
	var map_name = "TestMap1.map"
	$Renderer/Map.load_map(map_name)
	$Renderer.clear_screen_buffer()
	$Renderer.set_camera_center(Vector3(1, 0, 0))
	var res_pos: Vector2 = $Renderer.voxel_map_space_to_screen_space(Vector3(0, 0, 0))
	assert(res_pos == Vector2(15, 10))  # I'm not 100% sure this is the right value....
	return true


func _test_small_map() -> bool:
	var map: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
		[
		  [1, 1, 1, 1, 1, 1],
		],
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
		[
		  [1, 0, 0, 0, 0, 1],
		],
	]
	$Renderer/Map.set_map(map)
	$Renderer.clear_screen_buffer()
	# $Renderer.set_camera_center($Renderer/Map.get_center_pos())
	$Renderer.set_camera_center(Vector3(0,0,7))
	$Renderer.draw_map()
	$Renderer.update_screen()
	return true


func _test_draw_level_1() -> bool:
	var map_name = "TestMap1.map"
	$Renderer/Map.load_map(map_name)
	$Renderer.clear_screen_buffer()
	$Renderer.set_camera_center($Renderer/Map.get_center_pos())
	$Renderer.draw_map()
	$Renderer.update_screen()
	return true
