extends State

func enter(host):
	# play idle animation
	pass

func handle_input(host, event):
	if event.is_action_pressed("move_up"):
		pass #host.change_state("jump")
		
	if event.is_action_pressed("move_down"):
		pass #host.change_state("sneak")

func update(host, delta):
	var input_direction = _get_input_direction()
	if input_direction:
		host.change_state("walk")

func _get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input_direction