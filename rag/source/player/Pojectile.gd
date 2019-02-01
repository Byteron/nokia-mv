class_name Projectile extends RigidBody2D

var speed = 0
var direction = Vector2(0, 0)
var motion = Vector2(0,0)

func initialize(speed):
	self.speed = speed

func _ready():
	direction = (get_global_mouse_position() - global_position).normalized()
	motion = Vector2(speed, speed) * direction
	linear_velocity = motion

func _process(delta):
	print(linear_velocity)

func _on_body_entered(body):
	queue_free() 


func _on_Timer_timeout():
	queue_free()
