extends Node2D

const Enemy = preload("res://scenes/Enemy.tscn")
const Wall = preload("res://scenes/Wall.tscn")
const Bomb = preload("res://scenes/Bomb.tscn")

var bombs = []
var walls = []
var enemies = []

var point = 0

const size = Vector2(64,64)
var walls_pos = []

var rng = RandomNumberGenerator.new()

func _ready():
	pass # Replace with function body.

func get_random_pos():
	rng.randomize()
	var random_numb = rng.randi_range(0, walls_pos.size()-1)
	return walls_pos[random_numb]

func _create_walls(cur_position):
	var wall = Wall.instance()
	add_child(wall)
	walls.append(wall)
	wall.position = cur_position + size/2

func _create_enemies(cur_position):
	var enemy = Enemy.instance()
	enemy.name = "RunningEnemy"
	add_child(enemy)
	enemies.append(enemy)
	if cur_position != $Player.position:
		enemy.position = cur_position + size/4
	else:
		_create_enemies(get_random_pos())

func _create_bomb(cur_position):
	var bomb = Bomb.instance()
	add_child(bomb)
	bombs.append(bomb)
	bomb.position = cur_position + size/4

func _draw():
	var cur_pos
	var screen_size = get_viewport().size
	
	for y in range(screen_size.y/size.y):
		for x in range(screen_size.x/size.x):
			if y%2 == 1:
				if x%2 == 1:
					cur_pos = Vector2((x*size.x),(y*size.y))
					walls_pos.append(cur_pos)
					_create_walls(cur_pos)
	_create_enemies(get_random_pos())
	get_node("Player").set_position(get_random_pos())

func _process(delta):
	var time = ceil($Timer.time_left)-1
	var str_time = "Time : "
	$TimeLabel.set_text(str_time + str(time))
	
	var str_point = "Point : "
	$PointLabel.set_text(str_point + str(point))

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_SPACE:
			_create_bomb(get_node("Player").position) 

func _on_Timer_timeout():
	_create_enemies(get_random_pos())
