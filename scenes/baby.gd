extends CharacterBody2D

const SPEED_SLEEPY : int = 30
const SPEED_NORMAL : int = 40
const SPEED_ANGRY : int = 60
var speed : int = SPEED_NORMAL

var emote_sleepy : Resource = load("res://assets/emotes/emote_sleeps.png")
var emote_angry : Resource = load("res://assets/emotes/emote_anger.png")

const SLEEPY_REACTION_TIME : Array = [1.0, 1.2]
const NORMAL_REACTION_TIME : Array = [0.4, 0.6]
const ANGRY_REACTION_TIME : Array = [0.1, 0.3]
var current_reaction_time : Array = NORMAL_REACTION_TIME
var current_expression : String

var collision
@export var animation_tree : Node
@export var player : Node2D
@onready var footsteps_sound : AudioStreamPlayer2D = $BabyFootsteps
@onready var footsteps_timer : Timer = $FootstepsTimer
@onready var footsteps_vol : float = footsteps_sound.volume_db
@onready var emote : Node2D = $Emote
@onready var emote_timer : Node = $EmoteTimer
@onready var nav_agent : Node = $NavigationAgent2D
@onready var new_path_timer : Node = $NewPathTimer
@onready var game_start_delay_timer : Timer = $GameStartDelayTimer

signal signal_game_over

func _ready() -> void:
	animation_tree.active = true
	emote.hide()
	signal_game_over.connect(get_parent().game_over)
	game_start_delay_timer.start()

func _physics_process(delta) -> void:
	if !Global.win && Global.game_start:
		if game_start_delay_timer.is_stopped():
			var dir = to_local(nav_agent.get_next_path_position()).normalized()
			velocity = dir * speed
			move_and_slide()
			
			# Get collision info
			for i in get_slide_collision_count():
				collision = get_slide_collision(i)
				# If baby collides with cat...
				if "FatCat" in collision.get_collider().name:
					# Stop baby from moving
					signal_game_over.emit()
					Global.game_over = true
					nav_agent.navigation_layers = 0
			
		play_move_animations()

func make_path() -> void:
	nav_agent.target_position = player.global_position

func play_move_animations() -> void:
	# If enemy not moving, travel to idle animation
	if velocity == Vector2.ZERO:
		animation_tree.get("parameters/playback").travel("Idle")
	elif current_expression == "sleepy":
		animation_tree.get("parameters/playback").travel("Run_Sleepy")
		animation_tree.set("parameters/Idle/blend_position", velocity)
		animation_tree.set("parameters/Run_Sleepy/blend_position", velocity)
	elif current_expression == "angry":
		animation_tree.get("parameters/playback").travel("Run_Angry")
		animation_tree.set("parameters/Idle/blend_position", velocity)
		animation_tree.set("parameters/Run_Angry/blend_position", velocity)
	else:
		# If enemy moving, travel to walk animation
		# Set blend positions (directions) of animations based on relative direction
		animation_tree.get("parameters/playback").travel("Run")
		animation_tree.set("parameters/Idle/blend_position", velocity)
		animation_tree.set("parameters/Run/blend_position", velocity)
		
	if velocity != Vector2.ZERO && footsteps_timer.is_stopped():
		footsteps_sound.pitch_scale = randf_range(0.9, 1.1)
		footsteps_sound.volume_db = randf_range(footsteps_vol-2.0, footsteps_vol+2.0)
		footsteps_sound.play()
		footsteps_timer.start()

# Randomise reaction time within a range based on what emotional response is 
# triggered (sleepy, normal, angry).
func set_reaction_time(current_reaction_time) -> void:
	new_path_timer.wait_time = randf_range(current_reaction_time[0], current_reaction_time[1])

# Update path to cat periodically, and randomise reaction time every new path.
func _on_timer_timeout() -> void:
	make_path()
	set_reaction_time(current_reaction_time)

func trigger_emote(expression:String) -> void:
	# Trigger emote after emote cooldown
	if emote_timer.is_stopped():
		current_expression = expression
		# Set baby speed and path finding reaction times based on response type
		# from the collided toy
		if expression == "sleepy":
			current_reaction_time = SLEEPY_REACTION_TIME
			speed = SPEED_SLEEPY
			set_emote(emote_sleepy)
		elif expression == "angry":
			current_reaction_time = ANGRY_REACTION_TIME
			speed = SPEED_ANGRY
			set_emote(emote_angry)

# Changes and shows emote icon, and start emote cooldown timer
func set_emote(emote_icon) -> void:
	emote.texture = emote_icon
	emote.show()
	emote_timer.start()

# Set baby's speed and reaction time back to normal after a short period
func _on_emote_timer_timeout():
	speed = SPEED_NORMAL
	current_reaction_time = NORMAL_REACTION_TIME
	emote.hide()
