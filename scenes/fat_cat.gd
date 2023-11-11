extends CharacterBody2D

var speed := 100
var target : Vector2

func _physics_process(delta):
	get_input()
	
	if global_position.distance_to(target) > 1:
		move_and_slide()

func get_input():
	if Input.is_mouse_button_pressed(1):
		target = get_global_mouse_position()
	
	velocity = global_position.direction_to(target) * speed
