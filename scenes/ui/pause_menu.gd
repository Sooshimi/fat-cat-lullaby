extends Control

func _ready():
	hide()

func _on_continue_pressed():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	hide()
