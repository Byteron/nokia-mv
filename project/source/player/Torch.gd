extends Node2D

const timeout = 0.3

var time = 0

onready var light = $Light2D

func _process(delta):
	if tick(delta):
		randomize()
		var new_scale = rand_range(1.6, 1.8)
		light.texture_scale = new_scale

func tick(delta):
	time += delta
	if time > timeout:
		time = 0
		return true
	return false