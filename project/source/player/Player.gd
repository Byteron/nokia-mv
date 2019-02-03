class_name Player extends KinematicBody2D

const GRAVITY = 196
const UP = Vector2(0, -1)
const DOWN = Vector2(0, 1)

const WALK_SPEED = 32
const JUMP_FORCE = 96

var direction = Vector2()
var motion = Vector2()

var facing = 1
var dashing = false

var enemy_in_reach = null

export(float, 0, 2) var hope = 1.0

onready var anim = $AnimationPlayer
onready var skin = $Skin

onready var torch = $Torch

func _ready():
	Global.player = self
	update_hope()

func _process(delta):
	update_motion(delta)

func update_motion(delta):
	update_direction()
	update_facing()
	fall(delta)
	walk()
	jump()
	move_and_slide_with_snap(motion, DOWN, UP)

func update_direction():
	var left = Input.is_action_pressed("ui_left")
	var right = Input.is_action_pressed("ui_right")
	direction.x = int(right) - int(left)

func update_facing():
	
	if facing == 1:
		skin.flip_h = false
		torch.position.x = 2
	
	else:
		skin.flip_h = true
		torch.position.x = -3
		
func walk():

	if direction.x:
		if is_on_floor() and not anim.current_animation == "land":
			play_anim("walk")
		motion.x = WALK_SPEED * direction.x
		facing = direction.x
	
	else:
		if is_on_floor() and not anim.current_animation == "land":
			play_anim("idle")
		motion.x = 0

func jump():
	var jump = Input.is_action_just_pressed("ui_accept")
	
	if jump and is_on_floor():
		play_anim("jump")
		motion.y = -JUMP_FORCE
	
	if not is_on_ceiling() and not is_on_floor():
		# motion.x *= 1.4
		if motion.y > 0:
			play_anim("fall")

func fall(delta):
	
	if is_on_ceiling():
		motion.y = 0
		print(motion)
	
	if is_on_floor():
		if anim.current_animation == "fall":
			play_anim("land")
		motion.y = 0
	
	else:
		motion.y += GRAVITY * delta
	
	if dashing and motion.x < -10 or motion.x > 10:
		motion.x -= GRAVITY * delta * facing
	elif dashing:
		motion.x = 0
		skin.scale = Vector2(1, 1)
		dashing = false
		facing = facing * -1
	
	motion.y = clamp(motion.y, -JUMP_FORCE, JUMP_FORCE)

func set_hope(new_hope):
	hope = clamp(new_hope, 0.1, 2)
	update_hope()

func update_hope():
	torch.update_hope(hope)

func play_anim(animation):
	if anim.current_animation != animation:
		print("Play: ", animation)
		anim.play(animation)

func _on_HitArea_body_entered(body):
	if body.is_in_group("Enemy"):
		enemy_in_reach = body

func _on_HitArea_body_exited(body):
	enemy_in_reach = null
