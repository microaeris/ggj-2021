extends Control

# Maps, because too lazy to parse from file
const MAP_1_DATA = [[[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 181, 45, 45, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 45, 45, 45, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 45, 45, 45, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 45, 45, 45, 45, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 181, 181, 181, 181, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 45, 45, 144, 144, 144, 0, 0]], [[0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0]]]
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
	else:
		print("Unsupported map")

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
