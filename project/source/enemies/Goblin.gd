extends Node2D

const TIMEOUT = 1
const SPEED = 25

var health = 3

var player = null
var player_goblin = null

var time = 0
var value = 0.1

onready var goblin = $Goblin
onready var sprite = $Goblin/Sprite
onready var anim = $Goblin/AnimationPlayer

func _process(delta):
	if player:
		var direction = goblin.global_position.x - player.global_position.x
		if direction < -5:
			goblin.global_position.x += SPEED * delta
			play_anim("walk")
			sprite.flip_h = false
		elif direction > 5:
			goblin.global_position.x -= SPEED * delta
			play_anim("walk")
			sprite.flip_h = true
		else:
			play_anim("idle")
	else:
		play_anim("idle")
	attack()
	
	if player_goblin and tick(delta):
		player_goblin.set_hope(player_goblin.hope - value)
		print("Hope: ", player_goblin.hope)

func attack():
	if player_goblin and Input.is_action_just_pressed("ui_down"):
		hurt()

func tick(delta):
	time += delta
	if time > TIMEOUT:
		time = 0
		return true
	return false

func hurt():
	health -= 1
	if health <= 0:
		queue_free()

func play_anim(animation):
	if anim.current_animation != animation:
		print("Play: ", animation)
		anim.play(animation)

func _on_Reach_body_entered(body):
	if body == Global.player:
		player = body

func _on_Reach_body_exited(body):
	if body == Global.player:
		player = null

func _on_Goblin_body_entered(body):
	if body == Global.player:
		player_goblin = body

func _on_Goblin_body_exited(body):
	if body == Global.player:
		player_goblin = null
