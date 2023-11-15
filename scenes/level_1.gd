extends Node

@export var pause_menu : Control
@export var game_over_menu : Control
@export var win_menu : Control
@export var game_over_meow : AudioStreamPlayer
@export var game_over_laugh : AudioStreamPlayer

var run_once_counter : int = 0

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
