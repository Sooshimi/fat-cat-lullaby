extends CharacterBody2D

var speed := 100
var target : Vector2
var is_moving : bool
var collision

func _physics_process(delta):
	get_input(delta)
	
	# Stop player from clicking whilst cat is moving
	if global_position.distance_to(target) > 10:
		is_moving = true
	else:
		is_moving = false
	
#	if collision:
#		# Allows player to slide on walls
#		velocity = velocity.slide(collision.get_normal())

func get_input(delta):
	if Input.is_action_just_pressed("left_click") && !is_moving:
		target = get_global_mouse_position()
	
	collision = move_and_collide(velocity * delta, false, 0.00)
	
	if is_moving:
		velocity = global_position.direction_to(target) * speed
	else:
		# Short cat slide after rolling
		velocity = velocity.move_toward(Vector2.ZERO, 6)
