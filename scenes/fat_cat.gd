extends CharacterBody2D

var speed : float = 100
var target : Vector2
var is_rolling : bool
var is_jumping : bool
var is_grounded : bool = true
var allow_jump : bool
var collision
var start_roll_position : Vector2
var start_jump_position : Vector2
var max_roll_length : int = 80
var max_jump_length : int = 80

@onready var roll_cooldown : Node = $RollCooldown
@onready var jump_window : Node = $JumpWindow
@onready var collision_shape : Node = $CollisionShape2D
@onready var animation_tree : AnimationTree = $AnimationTree

signal signal_game_over

func _ready() -> void:
	# Stop cat moving at first launch of game
	target = global_position
	signal_game_over.connect(get_parent().game_over)
	animation_tree.active = true

func play_move_animations() -> void:
	# If enemy not moving, travel to idle animation
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/slide_to_idle"] = true
	else:
		animation_tree["parameters/conditions/idle"] = false

func _physics_process(delta) -> void:
	play_move_animations()
	
	if !Global.game_over && !Global.win && Global.game_start:
		if Input.is_action_just_pressed("left_click") && !is_rolling:
			animation_tree["parameters/conditions/idle_to_roll"] = true
			animation_tree["parameters/conditions/roll_to_slide"] = false
			animation_tree.get("parameters/playback").travel("Roll")
			start_roll_position = global_position
			target = get_global_mouse_position()
			is_rolling = true
			allow_jump = true
		else:
			# Limit roll length, to distance of mouse click, or max roll length
			if ((global_position.distance_to(target) < 5) ||\
				(global_position.distance_to(start_roll_position) > max_roll_length)) &&\
				is_rolling:
					animation_tree["parameters/conditions/roll_to_slide"] = true
					animation_tree["parameters/conditions/slide_to_idle"] = false
					animation_tree["parameters/conditions/slide_to_roll"] = false
					is_rolling = false
					is_grounded = true
					# Start window where jump action is allowed shortly during slide
					jump_window.start()
			# Limit jump length, to distance of mouse click, or max jump length
			elif ((global_position.distance_to(target) < 5) ||\
				(global_position.distance_to(start_jump_position) > max_jump_length)) &&\
				is_jumping:
					animation_tree["parameters/conditions/land"] = true
					animation_tree["parameters/conditions/jump"] = false
					# Turn player collision box back on after landing
					collision_shape.disabled = false
					is_rolling = false
					is_grounded = true
					is_jumping = false
					jump_window.start()
		
		# Cat rolling or jumping
		if is_rolling || is_jumping:
			# Move cat
			velocity = global_position.direction_to(target) * speed
		# Cat sliding
		else:
			# Short cat slide after rolling/jumping has finished
			if is_grounded:
				# Rolling to slide to idle
				animation_tree["parameters/conditions/slide_to_idle"] = true
				animation_tree["parameters/conditions/idle_to_roll"] = false
			velocity = velocity.move_toward(Vector2.ZERO, 8)
			
			# Allow one jump during this window
			if Input.is_action_just_pressed("jump") &&\
				!jump_window.is_stopped() &&\
				is_grounded &&\
				allow_jump:
				# JUMPING
				animation_tree["parameters/conditions/jump"] = true
				animation_tree["parameters/conditions/land"] = false
				animation_tree["parameters/conditions/slide_to_idle"] = false
				collision_shape.disabled = true
				is_grounded = false
				is_rolling = true
				is_jumping = true
				allow_jump = false
				
				start_jump_position = global_position
				# Sets mouse position as the jumping target
				target = get_global_mouse_position()
		
		collision = move_and_collide(velocity * delta, false, 0.00)
		
		if collision:
			is_rolling = false
			is_grounded = true
			animation_tree.get("parameters/playback").travel("Slide")
			# Allows player to slide on walls
			velocity = velocity.slide(collision.get_normal())
			
			if "Baby" in collision.get_collider().name:
				signal_game_over.emit()
