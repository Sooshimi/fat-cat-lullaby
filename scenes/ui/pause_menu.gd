extends Control

func _ready() -> void:
	hide()

func _on_continue_pressed() -> void:
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()

func _on_main_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	AudioScene.toy_music.stop()

func _on_quit_pressed() -> void:
	get_tree().quit()
