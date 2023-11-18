extends Node

var game_over : bool = false
var win : bool = false
var current_scene

# ["B0", "C1", "Cs1", "D1", "Eb1", "E1", "F1", "Fs1", "G1", "Ab1", "A1",\
#  "Bb1", "B1", "C2", "Cs2", "D2", "Eb2", "E2"]

var keys_played : Array = []
var lullaby : Array = ["e1", "g1", "b1"]

signal signal_win

func _ready() -> void:
	pass

func get_scene():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1)
	return current_scene

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
		win = true
		signal_win.connect(get_scene().win)
		signal_win.emit()
		keys_played = []
