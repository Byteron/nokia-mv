extends State

export(int) var MAX_WALK_SPEED = 200
export(int) var MAX_RUN_SPEED = 300

var speed
var motion

func enter(host):
	# play walk animation
	pass

func handle_input(host, event):
	if event.is_action_pressed("move_up"):
		pass # host.change_state("jump")
	if event.is_action_pressed("move_down"):
		pass # host.change_state("crouch")

func update(host, delta):
	var input_direction = _get_input_direction()
	if not input_direction:
		host.change_state("idle")
	_update_look_direction(host, input_direction)
	speed = MAX_RUN_SPEED if Input.is_action_pressed("run") else MAX_WALK_SPEED
	_move(host, speed, input_direction)

func _update_look_direction(host, input_direction):
	pass

func _move(host, speed, direction):
	host.move_and_slide_with_snap(speed * direction, Vector2(0, 1))

func _get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	return input_direction