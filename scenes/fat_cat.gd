extends CharacterBody2D

var speed : float = 100
var target : Vector2
var is_rolling : bool
var is_jumping : bool
var is_grounded : bool = true
var collision
var start_roll_position : Vector2
var start_jump_position : Vector2
var max_roll_length : int = 60
var max_jump_length : int = 50

@onready var roll_cooldown : Node = $RollCooldown
@onready var jump_window : Node = $JumpWindow
@onready var collision_shape : Node = $CollisionShape2D

func _ready() -> void:
	# Stop cat moving at first launch of game
	target = global_position

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("left_click") && !is_rolling:
		start_roll_position = global_position
		target = get_global_mouse_position()
		is_rolling = true
	else:
		# Limit roll length, to distance of mouse click, or max roll length
		if (global_position.distance_to(target) < 5) ||\
			(global_position.distance_to(start_roll_position) > max_roll_length) &&\
			is_rolling:
				# Turn player collision box back on after landing
				collision_shape.disabled = false
				is_rolling = false
				is_grounded = true
				# Start window where jump action is allowed shortly during slide
				jump_window.start()
		# Limit jump length, to distance of mouse click, or max jump length
		elif (global_position.distance_to(target) < 5) ||\
			(global_position.distance_to(start_jump_position) > max_jump_length) &&\
			!is_grounded:
				collision_shape.disabled = false
				is_rolling = false
				is_grounded = true
				jump_window.start()
	
	collision = move_and_collide(velocity * delta, false, 0.00)
	
	# Cat rolling or jumping
	if is_rolling || !is_grounded:
		# Move cat
		velocity = global_position.direction_to(target) * speed
	# Cat sliding
	else:
		# Short cat slide after rolling/jumping has finished
		velocity = velocity.move_toward(Vector2.ZERO, 7)
		
		# Allow one jump during this window
		if Input.is_action_just_pressed("jump") && !jump_window.is_stopped() && is_grounded:
			# JUMPING
			collision_shape.disabled = true
			is_grounded = false
			is_rolling = true
			print("Jump")
			
			start_jump_position = global_position
			# Sets mouse position as the jumping target
			target = get_global_mouse_position()
