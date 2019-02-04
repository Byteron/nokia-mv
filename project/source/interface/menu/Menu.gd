extends Control

const DARK = Color("c7f0d8")
const LIGHT = Color("43523d")

var active_button = 0

var up
var down
var enter

onready var buttons = [
	$CenterContainer/VBoxContainer/Buttons/Play,
	# $CenterContainer/VBoxContainer/Buttons/Controls,
	$CenterContainer/VBoxContainer/Buttons/Exit
]

onready var highlight = $ColorRect

func _ready():
	change_active_button(0)
func _input(event):
	up = Input.is_action_just_pressed("ui_up")
	down = Input.is_action_just_pressed("ui_down")
	enter = Input.is_action_just_pressed("ui_accept")
	if up:
		var index = int(active_button - 1) % buttons.size()
		change_active_button(index)
	if down:
		var index = int(active_button + 1) % buttons.size()
		change_active_button(index)
	if enter:
		if active_button == 0:
			get_tree().change_scene(Global.Level1)
		if active_button == 1:
			get_tree().quit()
			
func change_active_button(index):
	buttons[active_button].add_color_override("font_color", DARK)
	active_button = index
	buttons[active_button].add_color_override("font_color", LIGHT)
	highlight.rect_global_position.y = buttons[active_button].rect_global_position.y