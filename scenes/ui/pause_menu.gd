extends Control

@onready var animation : AnimationPlayer = $MarginContainer/VBoxContainer/MarginContainer2/AnimationPlayer
@onready var button_click_sound : AudioStreamPlayer = $ButtonClickSound
@onready var button_hover_sound : AudioStreamPlayer = $ButtonHoverSound

func _ready() -> void:
	hide()

func _process(delta) -> void:
	animation.play("play")

func _on_continue_pressed() -> void:
	button_click_sound.play()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()

func _on_main_menu_pressed():
	button_click_sound.play()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")
	AudioScene.toy_music.stop()

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_continue_mouse_entered():
	button_hover_sound.play()

func _on_main_menu_mouse_entered():
	button_hover_sound.play()

func _on_quit_mouse_entered():
	button_hover_sound.play()
