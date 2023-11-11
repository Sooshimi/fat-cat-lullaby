extends CharacterBody2D

var speed : float = 100
var target : Vector2
var is_rolling : bool
var is_jumping : bool
var is_grounded : bool = true
var collision

@onready var roll_cooldown : Node = $RollCooldown
@onready var jump_window : Node = $JumpWindow
@onready var collision_shape : Node = $CollisionShape2D

func _ready() -> void:
	# Stop cat moving at first launch of game
	target = global_position

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("left_click") && !is_rolling:
		target = get_global_mouse_position()
		is_rolling = true
	else:
		# 'i' variable is to stop this block running more than once. 
		if global_position.distance_to(target) < 5 && is_rolling:
			# SLIDING
			# Turn player collision box back on after landing
			collision_shape.disabled = false
			is_rolling = false
			is_grounded = true
			# Start window where jump action is allowed shortly during slide
			jump_window.start()
	
	collision = move_and_collide(velocity * delta, false, 0.00)
	
	# Cat rolling
	if is_rolling:
		# Move cat
		velocity = global_position.direction_to(target) * speed
	# Cat sliding
	else:
		# Short cat slide after rolling until stopped
		velocity = velocity.move_toward(Vector2.ZERO, 7)
		
		# Allow one jump during this window
		if Input.is_action_just_pressed("jump") && !jump_window.is_stopped() && is_grounded:
			# JUMPING
			collision_shape.disabled = true
			is_grounded = false
			is_rolling = true
			print("Jump")
			
			# Sets mouse position as the jumping target
			target = get_global_mouse_position()
	
	if !is_grounded:
		# New velocity and direction when jumping
		velocity = global_position.direction_to(target) * speed
	
#	if collision:
#		# Allows player to slide on walls
#		velocity = velocity.slide(collision.get_normal())
