extends Control

@export var play_button : Button
@export var quit_button : Button
@export var button_click_sound : AudioStreamPlayer
@export var button_hover_sound : AudioStreamPlayer
@export var fade_out_timer : Timer
@export var canvas : CanvasModulate
@export var music : AudioStreamPlayer
@onready var animation : AnimationPlayer = $MarginContainer/VBoxContainer/MarginContainer2/AnimationPlayer

var play_pressed : bool = false

func _process(delta):
	if play_pressed:
		canvas.color = lerp(canvas.color, Color(0,0,0,1), 5 * delta)
		music.volume_db = lerp(music.volume_db, -80.0, 0.8 * delta)
	if Global.win:
		AudioScene.game_over_music.stop()
	
	animation.play("play")

func _on_play_pressed() -> void:
	button_click_sound.play()
	fade_out_timer.start()
	play_pressed = true
	play_button.disabled = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await fade_out_timer.timeout
	play_pressed = false
	
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Global.game_over = false
	Global.win = false

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_play_mouse_entered():
	button_hover_sound.play()

func _on_credits_pressed():
	get_tree().change_scene_to_file("res://scenes/ui/credits.tscn")
	button_click_sound.play()

func _on_credits_mouse_entered():
	button_hover_sound.play()

func _on_quit_mouse_entered():
	button_hover_sound.play()
