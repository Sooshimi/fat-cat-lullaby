extends Node2D

@onready var b0 : Node = $B0/AudioStreamPlayer
@onready var c1 : Node = $C1/AudioStreamPlayer
@onready var cs1 : Node = $Cs1/AudioStreamPlayer
@onready var d1 : Node = $D1/AudioStreamPlayer
@onready var ds1 : Node = $Ds1/AudioStreamPlayer
@onready var e1 : Node = $E1/AudioStreamPlayer
@onready var f1 : Node = $F1/AudioStreamPlayer
@onready var fs1 : Node = $Fs1/AudioStreamPlayer
@onready var g1 : Node = $G1/AudioStreamPlayer
@onready var gs1 : Node = $Gs1/AudioStreamPlayer
@onready var a1 : Node = $A1/AudioStreamPlayer
@onready var as1 : Node = $As1/AudioStreamPlayer
@onready var b1 : Node = $B1/AudioStreamPlayer
@onready var c2 : Node = $C2/AudioStreamPlayer
@onready var cs2 : Node = $Cs2/AudioStreamPlayer
@onready var d2 : Node = $D2/AudioStreamPlayer
@onready var ds2 : Node = $Ds2/AudioStreamPlayer
@onready var e2 : Node = $E2/AudioStreamPlayer

signal key_played

func _ready() -> void:
	key_played.connect(Global.check_key_order)

func _emit_key_played() -> void:
	key_played.emit()

func play_sound_and_append_and_emit(key_sound_node:Node, key_letter:String) -> void:
	key_sound_node.play()
	Global.keys_played.append(key_letter)
	_emit_key_played()

func _on_b_0_body_entered(body):
	play_sound_and_append_and_emit(b0, "B0")

func _on_c_1_body_entered(body):
	play_sound_and_append_and_emit(c1, "C1")

func _on_cs_1_body_entered(body):
	play_sound_and_append_and_emit(cs1, "Cs1")

func _on_d_1_body_entered(body):
	play_sound_and_append_and_emit(d1, "D1")

func _on_ds_1_body_entered(body):
	play_sound_and_append_and_emit(ds1, "Ds1")

func _on_e_1_body_entered(body):
	play_sound_and_append_and_emit(e1, "E1")

func _on_f_1_body_entered(body):
	play_sound_and_append_and_emit(f1, "F1")

func _on_fs_1_body_entered(body):
	play_sound_and_append_and_emit(fs1, "Fs1")

func _on_g_1_body_entered(body):
	play_sound_and_append_and_emit(g1, "G1")

func _on_gs_1_body_entered(body):
	play_sound_and_append_and_emit(gs1, "Gs1")

func _on_a_1_body_entered(body):
	play_sound_and_append_and_emit(a1, "A1")

func _on_as_1_body_entered(body):
	play_sound_and_append_and_emit(as1, "As1")

func _on_b_1_body_entered(body):
	play_sound_and_append_and_emit(b1, "B1")

func _on_c_2_body_entered(body):
	play_sound_and_append_and_emit(c2, "C2")

func _on_cs_2_body_entered(body):
	play_sound_and_append_and_emit(cs2, "Cs2")

func _on_d_2_body_entered(body):
	play_sound_and_append_and_emit(d2, "D2")

func _on_ds_2_body_entered(body):
	play_sound_and_append_and_emit(ds2, "Ds2")

func _on_e_2_body_entered(body):
	play_sound_and_append_and_emit(e2, "E2")
