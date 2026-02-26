extends Node

# Returns the value for the key if it exists, otherwise returns null
# Allows for safe access into godots insane dictionary type
func dict_get_or_null(dictionary: Dictionary, key) -> Variant:
	if dictionary.has(key):
		return dictionary[key]
	return null

func get_player() -> Player:
	# TODO update this to the name of our actual combat scene
	assert(get_tree().get_current_scene().name == "Test", "get_objects called outside of combat scene")
	return get_tree().get_root().get_node("/root/Test/Objects/Player") as Player

# use to get the projectiles root node in a combat scene
func get_projectiles() -> Node2D:
	# TODO update this to the name of our actual combat scene
	assert(get_tree().get_current_scene().name == "Test", "get_objects called outside of combat scene")
	return get_tree().get_root().get_node("/root/Test/Objects/Projectiles") as Node2D
