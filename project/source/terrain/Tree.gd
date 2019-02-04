extends Sprite

func _on_Area2D_body_entered(body):
	if body == Global.player:
		get_tree().change_scene(Global.Victory)
