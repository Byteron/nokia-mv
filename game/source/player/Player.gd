extends KinematicBody2D

signal state_changed(state)

onready var STATES = {
	idle = $States/Idle,
	walk = $States/Walk,
	#jump = $States/Jump,
	#fall = $States/Fall,
	#sneak = $States/Sneak
}

var look_direction = Vector2()

var current_state = null

func _undhandled_input(event):
	current_state.handle_input(self, event)

func _ready():
	change_state("idle")

func _physics_process(delta):
	current_state.update(self, delta)

func change_state(state):
	if current_state:
		current_state.exit(self)
	current_state = STATES[state]
	current_state.enter(self)
	emit_signal("state_changed", current_state.name)