extends Node2D

const timeout = 0.4

var hope = 1.0

var time = 0

onready var light = $Light2D
onready var particles = $Particles2D
func _process(delta):
	if tick(delta):
		randomize()
		var scale_offset = rand_range(0.05, -0.05)
		light.texture_scale = hope + scale_offset
		if particles.amount != int(hope * 10):
			particles.amount = int(hope * 10)
		

func update_hope(new_hope):
	hope = new_hope

func tick(delta):
	time += delta
	if time > timeout:
		time = 0
		return true
	return false