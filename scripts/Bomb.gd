extends KinematicBody2D

export (int) var speed = 100
var velocity = Vector2()
var move = 1

onready var obj = get_parent().get_node("RunningEnemy")

func _ready():
	pass

func _physics_process(delta):
	if is_instance_valid(obj):
		var velocity = (obj.global_position - global_position).normalized()
		var collision = move_and_collide(velocity * speed * delta)
		if collision:
			velocity = velocity.bounce(collision.normal)
			move_and_collide(velocity)
			print(collision.collider.name)
			if collision.collider in get_parent().enemies:
				_on_Area2D_body_entered(self)
	else:
		_on_Area2D_body_entered(self)


func _on_Area2D_body_entered(body):
	body.queue_free()
