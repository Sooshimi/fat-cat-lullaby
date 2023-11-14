extends RigidBody2D

@onready var note : Node = $AudioStreamPlayer
@onready var note_timer : Node = $NoteTimer
@onready var baby : CharacterBody2D = get_parent().get_node("Baby")

@export_enum("C", "D", "E") var key_1 : String
@export_enum("C", "D", "E") var key_2 : String
@export_enum("C", "D", "E") var key_3 : String
var tune : Array

@export_enum("sleepy", "normal", "angry") var baby_emotion_trigger : String

func _ready() -> void:
	load_keys()

func load_keys() -> void:
	var key_array : Array = [key_1, key_2, key_3]
	var format_path_string : String = "res://audio/keys/%s.ogg"
	
	for i in key_array.size():
		var key : String = key_array[i]
		var key_string : String = format_path_string % key
		var load_key : Resource = load(key_string)
		tune.append(load_key)

func _on_area_2d_body_entered(_body) -> void:
	baby.trigger_emote(baby_emotion_trigger)
	
	for key in tune:
		note.stream = key
		note.play()
		note_timer.start()
		await note_timer.timeout
