extends Node

var game_over : bool = false
var win : bool = false

var keys_played : Array = []
var lullaby : Array = ["e", "d", "c"]

func check_key_order() -> void:
	# Check every key pressed by player
	for i in keys_played.size():
		# Get the string of the actual key played
		var key : String = keys_played[i]
		# Check if the key doesn't match the corresponding lullaby note
		if key != lullaby[i]:
			# Reset array if wrong notes played in order
			keys_played = []
	
	# Correct if entire played array matches the order of notes in the lullaby
	if keys_played == lullaby:
		print("Correct order!")
		win = true
		keys_played = []
