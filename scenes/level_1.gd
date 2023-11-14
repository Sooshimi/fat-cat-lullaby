extends Node

@export var pause_menu : Control
@export var game_over_menu : Control

func game_over():
	game_over_menu.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _unhandled_input(_event) -> void:
	if !Global.game_over:
		if Input.is_action_just_pressed("escape"):
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			pause_menu.show()
