class_name Player extends KinematicBody2D

const GRAVITY = 180
const UP = Vector2(0, -1)

const SNEAK_SPEED = 10
const WALK_SPEED = 30
const RUN_SPEED = 60
const JUMP_FORCE = 80

var direction = Vector2()
var motion = Vector2()

var facing = 1
var dashing = false

onready var anim = $AnimationPlayer
onready var skin = $Skin

onready var torch = $Torch

func _process(delta):
	update_motion(delta)

func update_motion(delta):
	update_direction()
	move()
	move_and_slide_with_snap(motion, Vector2(0, 1), UP)
	fall(delta)
	update_facing()

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
		
func move():
	if Input.is_action_pressed("run"):
		run(RUN_SPEED)
		jump()
	elif Input.is_action_pressed("sneak"):
		run(SNEAK_SPEED)
		dash()
	else:
		run(WALK_SPEED)
		jump()
	
func run(MAX_SPEED):
	if direction.x and not dashing:
		
		play_anim("walk")
		motion.x = MAX_SPEED * direction.x
		facing = direction.x
	
	elif not dashing:
		play_anim("idle")
		motion.x = 0

func dash():
	var dash = Input.is_action_just_pressed("ui_accept")
	
	if dash and is_on_floor() and not dashing:
		dashing = true
		skin.scale = Vector2(1, 0.5)
		motion.x = facing * JUMP_FORCE * 1.2
	
func jump():
	var jump = Input.is_action_just_pressed("ui_accept")
	
	if jump and is_on_floor():
		motion.y = -JUMP_FORCE
	
	if not is_on_ceiling()and not is_on_floor():
		motion.x *= 1.4

func fall(delta):
	
	if is_on_ceiling():
		motion.y = 0
		print(motion)
	
	if is_on_floor() :
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

func play_anim(animation):
	if anim.current_animation != animation:
		anim.play(animation)