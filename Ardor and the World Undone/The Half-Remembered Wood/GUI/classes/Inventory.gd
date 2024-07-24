class_name Inventory
extends Resource
#based on godotneers extensible game data demonstration, adapt as needed.

@export var _content : Array[Item] = []

func add_item(to_add : Item):
	_content.append(to_add)


func remove_item(to_remove : Item):
	_content.erase(to_remove)


func get_items() -> Array[Item]:
	return _content


func has_all(items : Array[Item]) -> bool:
	var needed : Array[Item] = items.duplicate()
	for available in _content:
		needed.erase(available)

	return needed.is_empty()
