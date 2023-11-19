extends Node

@export var pause_menu : Control
@export var game_over_menu : Control
@export var win_menu : Control
@export var game_over_meow : AudioStreamPlayer
@export var game_over_laugh : AudioStreamPlayer
@export var player : CharacterBody2D
@export var baby : CharacterBody2D

@onready var player_light : PointLight2D = $FatCat/PlayerLight
@onready var shadow_light : PointLight2D = $FatCat/ShadowLight
@onready var dim_light : CanvasModulate = $CanvasModulate
@onready var dim_light_timer : Timer = $RoomLightTimer
@onready var light_switch : AudioStreamPlayer = $LightSwitch
@onready var ui : Control = $CanvasLayer/UI
@onready var game_over_screen_timer : Timer = $GameOverBlackFadeTimer
@onready var game_over_black_screen : ColorRect = $CanvasLayer/ColorRect
@onready var cam_overlay : MarginContainer = $CanvasLayer/MarginContainer

var run_once_counter : int = 0
var win_fade_to_black : bool = false

func _ready() -> void:
	Global.game_start = false
	dim_light_timer.start()

func _process(delta):
	if Global.game_start:
		player_light.texture_scale -= 0.01 * delta
		player_light.texture_scale = clamp(player_light.texture_scale, 0.0, 1.0)
		shadow_light.texture_scale -= 0.01 * delta
		shadow_light.texture_scale = clamp(shadow_light.texture_scale, 0.0, 1.0)
	
	if win_fade_to_black:
		game_over_black_screen.color = lerp(game_over_black_screen.color, Color(0,0,0,1), 0.1 * delta)

func game_over():
	run_once_counter += 1
	if run_once_counter == 1:
		game_over_meow.play()
		game_over_laugh.play()
		game_over_menu.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func win():
	var camera : Camera2D = player.get_node("Camera2D")
	camera.global_position = baby.global_position
	baby.trigger_emote("sleepy", true)
	baby.get_node("BabyLight").show()
	baby.get_node("Sprite2D/LightOccluder2D").hide()
	baby.animation_tree.get("parameters/playback").travel("Idle_Sleepy")
	AudioScene.play_game_over_music()
	game_over_screen_timer.start()
	win_fade_to_black = true
	cam_overlay.hide()
	ui.hide()
	await game_over_screen_timer.timeout
	win_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(_event) -> void:
	if !Global.game_over:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pause_menu.show()

func _on_room_light_timer_timeout():
	light_switch.play()
	dim_light.show()
	player_light.show()
	ui.show()
	Global.game_start = true
