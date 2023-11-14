extends CharacterBody2D

const SPEED_SLEEPY : int = 20
const SPEED_NORMAL : int = 40
const SPEED_ANGRY : int = 60
var speed : int = SPEED_NORMAL

var emote_sleepy : Resource = load("res://assets/emotes/emote_sleeps.png")
var emote_angry : Resource = load("res://assets/emotes/emote_anger.png")

const SLEEPY_REACTION_TIME : Array = [1.0, 1.2]
const NORMAL_REACTION_TIME : Array = [0.4, 0.6]
const ANGRY_REACTION_TIME : Array = [0.1, 0.3]
var current_reaction_time : Array = NORMAL_REACTION_TIME

var collision
@export var animation_tree : Node
@export var player : Node2D
@onready var emote : Node2D = $Emote
@onready var emote_timer : Node = $EmoteTimer
@onready var nav_agent : Node = $NavigationAgent2D
@onready var new_path_timer : Node = $NewPathTimer

func _ready() -> void:
	animation_tree.active = true
	emote.hide()

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

func set_reaction_time(current_reaction_time) -> void:
	new_path_timer.wait_time = randf_range(current_reaction_time[0], current_reaction_time[1])

func _on_timer_timeout() -> void:
	make_path()
	set_reaction_time(current_reaction_time)

func trigger_emote(expression:String) -> void:
	if emote_timer.is_stopped():
		if expression == "sleepy":
			current_reaction_time = SLEEPY_REACTION_TIME
			speed = SPEED_SLEEPY
			set_emote(emote_sleepy)
		elif expression == "angry":
			current_reaction_time = ANGRY_REACTION_TIME
			speed = SPEED_ANGRY
			set_emote(emote_angry)

func set_emote(emote_icon) -> void:
	emote.texture = emote_icon
	emote.show()
	emote_timer.start()

func _on_emote_timer_timeout():
	speed = SPEED_NORMAL
	current_reaction_time = NORMAL_REACTION_TIME
	emote.hide()
