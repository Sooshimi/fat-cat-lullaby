extends Node2D

@onready var key_c := $KeyCArea/AudioStreamPlayer
@onready var key_d := $KeyDArea/AudioStreamPlayer
@onready var key_e := $KeyEArea/AudioStreamPlayer

signal key_played

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _emit_key_played():
	key_played.connect(Global.check_key_order)
	key_played.emit()

func play_sound_and_append_and_emit(key_sound_node:Node, key_letter:String):
	key_sound_node.play()
	Global.keys_played.append(key_letter)
	_emit_key_played()

func _on_key_c_area_body_entered(body):
	play_sound_and_append_and_emit(key_c, "c")

func _on_key_d_area_body_entered(body):
	play_sound_and_append_and_emit(key_d, "d")

func _on_key_e_area_body_entered(body):
	play_sound_and_append_and_emit(key_e, "e")
