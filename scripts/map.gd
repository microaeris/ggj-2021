extends Control
signal new_map_loaded

# Maps, because too lazy to parse from file
const MAP_1_DATA = [[[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 181, 45, 45, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 45, 45, 45, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 45, 45, 45, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 45, 45, 45, 45, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 181, 181, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 45, 45, 144, 144, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 0, 0, 1],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 1],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 0, 0, 1],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 1, 1, 1, 0, 0],
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 1],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]  # df0ed0920b8796364539dcb18114e30f55e0a4ab
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 1, 1, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#	[
#		[0, 0, 1, 1, 1, 1],
#		[0, 0, 1, 1, 1, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#		[0, 0, 0, 0, 0, 0],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[1, 1, 1, 1],
#		[1, 0, 0, 1],
#		[1, 0, 0, 1],
#		[1, 1, 1, 1],
#	],
#	[
#		[1, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[1, 0, 0, 1],
#	],
#	[
#		[1, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[1, 0, 0, 1],
#	],
#	[
#		[1, 1, 1, 1],
#		[1, 0, 0, 1],
#		[1, 0, 0, 1],
#		[1, 1, 1, 1],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#	],
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#	],
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#	],
#	[
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#	],
#]
#var MAP_1_DATA: Array = [  # 3D array of bools. If >0, it means a vowel exists there.
#	[
#		[1, 1, 1, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#	],
#	[
#		[1, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 1],
#	],
#	[
#		[1, 0, 0, 1],
#		[0, 0, 0, 0],
#		[0, 0, 0, 0],
#		[0, 0, 0, 1],
#	],
#	[
#		[1, 1, 1, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#		[0, 0, 0, 1],
#	],
#]

const MAP_1_POI = [[[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 1, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]]
const MAP_1_FLAG = Vector3(5, 3, 5)

const FLAG_ID = 1

# Points of interest. 3d-array including flag location, items, etc.
var poi = null
# 3d-array of map data
var map = null
# Flag location as Vector3
var flag = null

func _ready():
	pass

func load_map(map_name):
	if map_name == "TestMap1.map":
		map = MAP_1_DATA
		poi = MAP_1_POI
		flag = MAP_1_FLAG
		emit_signal("new_map_loaded")
	else:
		print("Unsupported map")

func set_map(map_arr):
	map = map_arr

func is_there_voxel_above(pos: Vector3) -> bool:
	if (pos.z + 1) >= len(map):
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z + 1][pos.y][pos.x] > 0


func is_there_voxel_below(pos: Vector3) -> bool:
	if (pos.z - 1) < 0:
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z - 1][pos.y][pos.x] > 0


func is_there_voxel_left(pos: Vector3) -> bool:
	if (pos.x - 1) < 0:
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z][pos.y][pos.x - 1] > 0


func is_there_voxel_right(pos: Vector3) -> bool:
	if (pos.x + 1) >= len(map[0][0]):
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z][pos.y][pos.x + 1] > 0


func is_there_voxel_behind(pos: Vector3) -> bool:
	if (pos.y - 1) < 0:
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z][pos.y - 1][pos.x] > 0


func is_there_voxel_infront(pos: Vector3) -> bool:
	if (pos.y + 1) >= len(map[0]):
		# Out of bounds index. No voxels exist there.
		return false
	return map[pos.z][pos.y + 1][pos.x] > 0


func is_valid_pos(pos: Vector3) -> bool:
	return ((pos.z >= 0) && (pos.z < len(map))) \
		&& ((pos.y >= 0) && (pos.y < len(map[0]))) \
		&& ((pos.x >= 0) && (pos.x < len(map[0][0])))


func voxel_exists_at_pos(pos: Vector3) -> bool:
	return map[pos.z][pos.y][pos.x] > 0


func get_map_len_z() -> int:
	return len(map)


func get_map_len_y() -> int:
	return len(map[0])


func get_map_len_x() -> int:
	return len(map[0][0])


func get_unique_numbers_in_map() -> Array:
	var result_set: Array = []
	for layer in map:
		for row in layer:
			for el in row:
				# 0 means no voxel, so leave it out
				if !result_set.has(el) and (el != 0):
						result_set.append(el)
	return result_set


func get_voxel_type(pos: Vector3) -> int:
	return map[pos.z][pos.y][pos.x]


#func load_map(map_name):
#	var file = File.new()
#	var map_path = "res://assets/maps/" + map_name
#	var err = file.open(map_path, File.READ)
#	if err != OK:
#		print("Failed to load " + map_path)
#		return null
#
#	poi = file.get_line()
#	map = file.get_line()
#
#	print(poi.get_class())
#
#	file.close()

#	for y in range(len(poi[0])):
#		# Traverse bottom to top
#		for z in range(len(poi)):
#			# Traverse from right to left
#			for x in range(len(poi[0][0]) - 1, -1, -1):
#				var pos: Vector3 = Vector3(x, y, z)
#
#				if poi[z][y][x] == FLAG_ID:
#					flag = pos
