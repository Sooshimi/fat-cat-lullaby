extends Control

@onready var button_click_sound : AudioStreamPlayer = $ButtonClickSound
@onready var button_hover_sound : AudioStreamPlayer = $ButtonHoverSound

func _ready() -> void:
	hide()

func _on_back_to_main_menu_pressed():
	button_click_sound.play()
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	AudioScene.toy_music.stop()

func _on_quit_pressed():
	get_tree().quit()

func _on_back_to_main_menu_mouse_entered():
	button_hover_sound.play()

func _on_quit_mouse_entered():
	button_hover_sound.play()
