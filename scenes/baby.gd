extends CharacterBody2D

var speed := 40
var player : Node
var relative_direction : Vector2
var collision
var chase : bool

@export var animation_tree : Node

func _ready() -> void:
	animation_tree.active = true

func _physics_process(delta) -> void:
	player = get_parent().get_node("FatCat")
	
	# Get relative direction between player and enemy position.
	# Normalize so length of vector is 1.
	relative_direction = (player.position - position).normalized()
	
	collision = move_and_collide(velocity * delta)
	
	play_move_animations()
	
	if collision:
		# Allows enemy to slide on walls
		velocity = velocity.slide(collision.get_normal())
	
	chase_player(player.position)

func chase_player(player_position:Vector2) -> void:
	# Sets chase condition if player is within range
	if position.distance_to(player_position) < 100:
		chase = true
	
	if chase:
		# Sets velocity which changes based on relative direction
		velocity = Vector2(relative_direction * speed)

func play_move_animations() -> void:
	# If enemy not moving, travel to idle animation
	if velocity == Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Idle")
	else:
		# If enemy moving, travel to walk animation
		# Set blend positions (directions) of animations based on relative direction
		animation_tree.get("parameters/playback").travel("Run")
		animation_tree.set("parameters/Idle/blend_position", relative_direction)
		animation_tree.set("parameters/Run/blend_position", relative_direction)
