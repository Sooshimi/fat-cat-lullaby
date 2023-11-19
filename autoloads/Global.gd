extends Node

var game_start : bool
var game_over : bool = false
var win : bool = false
var current_scene

#("c0", "c1", "cs1", "d1", "eb1", "e1", "f1", "fs1", "g1", "ab1",\
#"a1", "bb1", "b1", "c2", "cs2", "d2", "eb2", "e2")

var keys_played : Array = []
var lullaby : Array = ["c1", "f1", "bb1"]

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
