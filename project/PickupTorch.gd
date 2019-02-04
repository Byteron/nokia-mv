extends Item

var value = 0.3

func _ready():
	$Torch.update_hope(0.3)

func _on_Area2D_body_entered(body):
	body.set_hope(body.hope + value)
	queue_free()