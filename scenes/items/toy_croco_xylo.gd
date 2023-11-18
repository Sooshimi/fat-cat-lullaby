extends RigidBody2D

@onready var note_timer : Node = $NoteTimer
@onready var baby : CharacterBody2D = get_parent().get_node("Baby")
@onready var audio_player : AudioStreamPlayer = $AudioStreamPlayer
@export var music : Resource
@export var piano : Node

@export_enum("c0", "c1", "cs1", "d1", "eb1", "e1", "f1", "fs1", "g1", "ab1",\
"a1", "bb1", "b1", "c2", "cs2", "d2", "eb2", "e2") var key_1 : String
@export_enum("c0", "c1", "cs1", "d1", "eb1", "e1", "f1", "fs1", "g1", "ab1",\
"a1", "bb1", "b1", "c2", "cs2", "d2", "eb2", "e2") var key_2 : String
@export_enum("c0", "c1", "cs1", "d1", "eb1", "e1", "f1", "fs1", "g1", "ab1",\
"a1", "bb1", "b1", "c2", "cs2", "d2", "eb2", "e2") var key_3 : String

# Holds the audio file loads of the played keys
var tune_load : Array
# Holds the strings of the played keys
var tune_strings : Array

@export_enum("sleepy", "normal", "angry") var baby_emotion_trigger : String

func _ready() -> void:
	load_keys()
	audio_player.stream = music

func load_keys() -> void:
	var key_array : Array = [key_1, key_2, key_3]
	var format_path_string : String = "res://audio/keys/%s.ogg"
	
	for i in key_array.size():
		var key : String = key_array[i]
		var key_string : String = format_path_string % key
		var load_key : Resource = load(key_string)
		tune_load.append(load_key)
		tune_strings.append(key)

func _on_area_2d_body_entered(_body) -> void:
	baby.trigger_emote(baby_emotion_trigger)
	audio_player.play()
	
	for i in tune_load.size():
		note_timer.start()
		piano.trigger_piano_key(tune_strings[i], false)
		await note_timer.timeout
