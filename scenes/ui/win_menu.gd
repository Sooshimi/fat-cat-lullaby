extends Control

func _ready() -> void:
	hide()

func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	AudioScene.toy_music.stop()
