extends Node2D

func _on_Area2D_body_entered(body):
	if body == Global.player:
		if body.backpack.use_key():
			queue_free()
	pass # Replace with function body.
