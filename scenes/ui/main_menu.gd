extends Control

@onready var play_button : Button = %Play

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.game_over = false

func _on_quit_pressed() -> void:
	get_tree().quit()
