extends Item

func _on_Area2D_body_entered(body):
	if body == Global.player:
		var key = Node.new()
		key.name = "Key"
		body.backpack.add_key(key)
		queue_free()