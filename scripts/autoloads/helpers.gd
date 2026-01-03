extends Node

# Returns the value for the key if it exists, otherwise returns null
# Allows for safe access into godots insane dictionary type
func dict_get_or_null(dictionary: Dictionary, key) -> Variant:
	if dictionary.has(key):
		return dictionary[key]
	return null

func get_player() -> Player:
	return get_tree().get_root().get_node("/root/Test/Objects/Player") as Player
