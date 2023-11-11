extends Node

var keys_played : Array = []
var lullaby : Array = ["e", "d", "c"]

func _unhandled_input(_event):
	if Input.is_action_pressed("escape"):
		get_tree().quit()
