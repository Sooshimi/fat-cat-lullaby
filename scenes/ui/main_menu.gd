extends Control

@export var play_button : Button
@export var fade_out_timer : Timer
@export var canvas : CanvasModulate
@export var music : AudioStreamPlayer

var play_pressed : bool = false

func _process(delta):
	if play_pressed:
		canvas.color = lerp(canvas.color, Color(0,0,0,1), 0.1)
		music.volume_db = lerp(music.volume_db, -80.0, 0.01)

func _on_play_pressed() -> void:
	fade_out_timer.start()
	play_pressed = true
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	await fade_out_timer.timeout
	play_pressed = false
	
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	Global.game_over = false
	Global.win = false

func _on_quit_pressed() -> void:
	get_tree().quit()
