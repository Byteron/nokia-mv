extends Item

const TIMEOUT = 1
var player = null

var time = 0
var value = 0.1

func _process(delta):
	if player and tick(delta):
		player.set_hope(player.hope - value)

func tick(delta):
	time += delta
	if time > TIMEOUT:
		time = 0
		return true
	return false

func _on_Area2D_body_entered(body):
	self.player = body

func _on_Area2D_body_exited(body):
	self.player = null