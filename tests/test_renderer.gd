extends Control

## Locals

# Add new test functions to this array
var test_bench = [
	"_test_is_there",
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
