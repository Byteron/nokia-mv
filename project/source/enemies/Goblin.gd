extends Node2D

const SPEED = 25

var player = null

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
