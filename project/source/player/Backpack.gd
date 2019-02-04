extends Node

onready var keys = $Keys

func add_key(key):
	keys.add_child(key)

func use_key():
	if keys.get_child_count() > 0:
		keys.get_child(0).queue_free()
		return true
	return false