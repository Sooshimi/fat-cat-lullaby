extends Node

var keys_played : Array = []
var lullaby : Array = ["e", "d", "c"]

func _unhandled_input(_event):
	if Input.is_action_pressed("escape"):
		get_tree().quit()

func check_key_order():
	for i in keys_played.size():
		var letter : String = keys_played[i]
		if letter != lullaby[i]:
			keys_played = []
	
	if keys_played == lullaby:
		print("Correct order!")
		keys_played = []
