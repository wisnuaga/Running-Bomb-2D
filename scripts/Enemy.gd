extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var move = 1
var health = 3

func _ready():
	pass

onready var obj = get_parent().get_node("Player")

func _physics_process(delta):
	var velocity = (obj.global_position - global_position).normalized()
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		move_and_collide(velocity)
		if collision.collider in get_parent().bombs:
			health -= 1
	if health == 0:
		_on_Area2D_body_entered(self)
		get_parent().point += 1

func _on_Area2D_body_entered(body):
	body.queue_free()