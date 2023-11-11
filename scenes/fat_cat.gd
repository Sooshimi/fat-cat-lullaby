extends CharacterBody2D

var speed : float = 100
var target : Vector2
var is_moving : bool
var is_jumping : bool
var is_grounded : bool = true
var collision
var i : int

@onready var roll_cooldown : Node = $RollCooldown
@onready var jump_duration : Node = $JumpDuration
@onready var jump_window : Node = $JumpWindow

func _ready() -> void:
	# Stop cat moving at first launch of game
	target = global_position

func _physics_process(delta) -> void:
	get_input(delta)
	
#	if collision:
#		# Allows player to slide on walls
#		velocity = velocity.slide(collision.get_normal())

func get_input(delta) -> void:
	if Input.is_action_just_pressed("left_click") && !is_moving:
		target = get_global_mouse_position()
		is_moving = true
		i += 1
	else:
		# 'i' variable is to stop this block running more than once. 
		if global_position.distance_to(target) < 3 && i == 1:
			i = 0
			is_moving = false
			# Start window where jump action is allowed shortly during slide
			jump_window.start()
	
	collision = move_and_collide(velocity * delta, false, 0.00)
	
	if is_moving:
		# Move cat
		velocity = global_position.direction_to(target) * speed
	else:
		# Short cat slide after rolling until stopped
		velocity = velocity.move_toward(Vector2.ZERO, 6)
		
		# Allow one jump during this window
		if Input.is_action_just_pressed("jump") && !jump_window.is_stopped() && is_grounded:
			is_grounded = false
			jump_duration.start()
			print("Jump")

func _on_jump_duration_timeout():
	is_grounded = true
	print("Landed")
