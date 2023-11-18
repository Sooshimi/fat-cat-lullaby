extends Node

@export var pause_menu : Control
@export var game_over_menu : Control
@export var win_menu : Control
@export var game_over_meow : AudioStreamPlayer
@export var game_over_laugh : AudioStreamPlayer
@export var player : CharacterBody2D

@onready var player_light : PointLight2D = $FatCat/PlayerLight
@onready var shadow_light : PointLight2D = $FatCat/ShadowLight

var run_once_counter : int = 0
var player_light_raw : float

func _process(delta):
	player_light.texture_scale -= 0.01 * delta
	player_light.texture_scale = clamp(player_light.texture_scale, 0.0, 1.0)
	shadow_light.texture_scale -= 0.01 * delta
	shadow_light.texture_scale = clamp(shadow_light.texture_scale, 0.0, 1.0)

func game_over():
	run_once_counter += 1
	if run_once_counter == 1:
		game_over_meow.play()
		game_over_laugh.play()
		game_over_menu.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func win():
	win_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(_event) -> void:
	if !Global.game_over:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pause_menu.show()
