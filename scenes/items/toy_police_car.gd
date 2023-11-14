extends RigidBody2D

@onready var note : Node = $AudioStreamPlayer
@onready var note_timer : Node = $NoteTimer
@onready var baby = get_parent().get_node("Baby")
@export var baby_emotion_trigger : String

var key_c := load("res://audio/3C.ogg")
var key_d := load("res://audio/3D.ogg")
var key_e := load("res://audio/3E.ogg")

var tune : Array = [key_e, key_d, key_c]

func _on_area_2d_body_entered(_body) -> void:
	baby.trigger_emote(baby_emotion_trigger)
	
	for key in tune:
		note.stream = key
		note.play()
		note_timer.start()
		await note_timer.timeout
