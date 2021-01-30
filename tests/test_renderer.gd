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
	return false
