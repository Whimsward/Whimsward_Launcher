class_name Item
extends Resource
#based on demo by godotneers on extensible, manageable game data

#Item's name
@export var name : String

#Item's icon (if needed)
@export var icon : Texture2D

#Item's "in-world" presentation and other logic
@export var scene : PackedScene

#godotneers example has func instantiate() using local var result to instance scene
#and calls initialize on the result if it has that method
func instantiate() -> CanvasItem:
	var result = scene.instantiate()
	if result.has_method("initialize"):
		result.initialize(self)
	return result
