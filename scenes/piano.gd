extends Node2D

@onready var key_c : Node = $KeyCArea/AudioStreamPlayer
@onready var key_d : Node = $KeyDArea/AudioStreamPlayer
@onready var key_e : Node = $KeyEArea/AudioStreamPlayer

signal key_played

func _ready() -> void:
	key_played.connect(Global.check_key_order)

func _emit_key_played() -> void:
	key_played.emit()

func play_sound_and_append_and_emit(key_sound_node:Node, key_letter:String) -> void:
	key_sound_node.play()
	Global.keys_played.append(key_letter)
	_emit_key_played()

func _on_key_c_area_body_entered(_body):
	play_sound_and_append_and_emit(key_c, "c")

func _on_key_d_area_body_entered(_body):
	play_sound_and_append_and_emit(key_d, "d")

func _on_key_e_area_body_entered(_body):
	play_sound_and_append_and_emit(key_e, "e")
