extends CharacterBody2D

var speed : int = 40

@export var animation_tree : Node
@export var player : Node2D
@onready var nav_agent : Node = $NavigationAgent2D

func _ready() -> void:
	animation_tree.active = true

func _physics_process(_delta) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	move_and_slide()
	
	play_move_animations()
	
func make_path() -> void:
	nav_agent.target_position = player.global_position

func play_move_animations() -> void:
	# If enemy not moving, travel to idle animation
	if velocity == Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Idle")
	else:
		# If enemy moving, travel to walk animation
		# Set blend positions (directions) of animations based on relative direction
		animation_tree.get("parameters/playback").travel("Run")
		animation_tree.set("parameters/Idle/blend_position", velocity)
		animation_tree.set("parameters/Run/blend_position", velocity)

func _on_timer_timeout() -> void:
	make_path()
