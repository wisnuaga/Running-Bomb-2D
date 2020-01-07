extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()

func _ready():
	pass # Replace with function body.

func set_position(cur_position):
	self.position = cur_position

func get_limit_move():
	var playerSize = Vector2(32,32)
	var screenSize = get_node(".").get_viewport().size
	return [screenSize.x-playerSize.x/2, screenSize.y-playerSize.y/2, playerSize.x/2, playerSize.y/2]

func get_input():
	var limit = get_limit_move()
	
	velocity = Vector2()
	if Input.is_action_pressed("ui_right") and position.x <= limit[0]:
		velocity.x += 1
	if Input.is_action_pressed("ui_left") and position.x >= limit[2]:
		velocity.x -= 1
	if Input.is_action_pressed("ui_down") and position.y <= limit[1]:
		velocity.y += 1
	if Input.is_action_pressed("ui_up") and position.y >= limit[3]:
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	var game_over = false
	get_input()
	velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		if get_slide_collision(i).collider in get_parent().enemies:
			get_tree().change_scene("res://scenes/GameOver.tscn")