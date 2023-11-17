extends Node2D

@onready var b0 : AudioStreamPlayer = $B0/AudioStreamPlayer
@onready var c1 : AudioStreamPlayer = $C1/AudioStreamPlayer
@onready var cs1 : AudioStreamPlayer = $Cs1/AudioStreamPlayer
@onready var d1 : AudioStreamPlayer = $D1/AudioStreamPlayer
@onready var eb1 : AudioStreamPlayer = $Eb1/AudioStreamPlayer
@onready var e1 : AudioStreamPlayer = $E1/AudioStreamPlayer
@onready var f1 : AudioStreamPlayer = $F1/AudioStreamPlayer
@onready var fs1 : AudioStreamPlayer = $Fs1/AudioStreamPlayer
@onready var g1 : AudioStreamPlayer = $G1/AudioStreamPlayer
@onready var ab1 : AudioStreamPlayer = $Ab1/AudioStreamPlayer
@onready var a1 : AudioStreamPlayer = $A1/AudioStreamPlayer
@onready var bb1 : AudioStreamPlayer = $Bb1/AudioStreamPlayer
@onready var b1 : AudioStreamPlayer = $B1/AudioStreamPlayer
@onready var c2 : AudioStreamPlayer = $C2/AudioStreamPlayer
@onready var cs2 : AudioStreamPlayer = $Cs2/AudioStreamPlayer
@onready var d2 : AudioStreamPlayer = $D2/AudioStreamPlayer
@onready var eb2 : AudioStreamPlayer = $Eb2/AudioStreamPlayer
@onready var e2 : AudioStreamPlayer = $E2/AudioStreamPlayer

@onready var b0_key : Sprite2D = $B0Sprite
@onready var c1_key : Sprite2D = $C1Sprite
@onready var cs1_key : Sprite2D = $Cs1Sprite
@onready var d1_key : Sprite2D = $D1Sprite
@onready var eb1_key : Sprite2D = $Eb1Sprite
@onready var e1_key : Sprite2D = $E1Sprite
@onready var f1_key : Sprite2D = $F1Sprite
@onready var fs1_key : Sprite2D = $Fs1Sprite
@onready var g1_key : Sprite2D = $G1Sprite
@onready var ab1_key : Sprite2D = $Ab1Sprite
@onready var a1_key : Sprite2D = $A1Sprite
@onready var bb1_key : Sprite2D = $Bb1Sprite
@onready var b1_key : Sprite2D = $B1Sprite
@onready var c2_key : Sprite2D = $C2Sprite
@onready var cs2_key : Sprite2D = $Cs2Sprite
@onready var d2_key : Sprite2D = $D2Sprite
@onready var eb2_key : Sprite2D = $Eb2Sprite
@onready var e2_key : Sprite2D = $E2Sprite

@onready var b0_light : PointLight2D = $B0/PointLight2D
@onready var c1_light : PointLight2D = $C1/PointLight2D
@onready var cs1_light : PointLight2D = $Cs1/PointLight2D
@onready var d1_light : PointLight2D = $D1/PointLight2D
@onready var eb1_light : PointLight2D = $Eb1/PointLight2D
@onready var e1_light : PointLight2D = $E1/PointLight2D
@onready var f1_light : PointLight2D = $F1/PointLight2D
@onready var fs1_light : PointLight2D = $Fs1/PointLight2D
@onready var g1_light : PointLight2D = $G1/PointLight2D
@onready var ab1_light : PointLight2D = $Ab1/PointLight2D
@onready var a1_light : PointLight2D = $A1/PointLight2D
@onready var bb1_light : PointLight2D = $Bb1/PointLight2D
@onready var b1_light : PointLight2D = $B1/PointLight2D
@onready var c2_light : PointLight2D = $C2/PointLight2D
@onready var cs2_light : PointLight2D = $Cs2/PointLight2D
@onready var d2_light : PointLight2D = $D2/PointLight2D
@onready var eb2_light : PointLight2D = $Eb2/PointLight2D
@onready var e2_light : PointLight2D = $E2/PointLight2D

@onready var key_dictionary : Dictionary =\
	{"b0" = {"sound": b0,\
			"colour_key": b0_key,\
			"light_key": b0_light},\
	"c1" = {"sound": c1,\
			"colour_key": c1_key,\
			"light_key": c1_light},\
	"cs1" = {"sound": cs1,\
			"colour_key": cs1_key,\
			"light_key": cs1_light},\
	"d1" = {"sound": d1,\
			"colour_key": d1_key,\
			"light_key": d1_light},\
	"eb1" = {"sound": eb1,\
			"colour_key": eb1_key,\
			"light_key": eb1_light},\
	"e1" = {"sound": e1,\
			"colour_key": e1_key,\
			"light_key": e1_light},\
	"f1" = {"sound": f1,\
			"colour_key": f1_key,\
			"light_key": f1_light},\
	"fs1" = {"sound": fs1,\
			"colour_key": fs1_key,\
			"light_key": fs1_light},\
	"g1" = {"sound": g1,\
			"colour_key": g1_key,\
			"light_key": g1_light},\
	"ab1" = {"sound": ab1,\
			"colour_key": ab1_key,\
			"light_key": ab1_light},\
	"a1" = {"sound": a1,\
			"colour_key": a1_key,\
			"light_key": a1_light},\
	"bb1" = {"sound": bb1,\
			"colour_key": bb1_key,\
			"light_key": bb1_light},\
	"b1" = {"sound": b1,\
			"colour_key": b1_key,\
			"light_key": b1_light},\
	"c2" = {"sound": c2,\
			"colour_key": c2_key,\
			"light_key": c2_light},\
	"cs2" = {"sound": cs2,\
			"colour_key": cs2_key,\
			"light_key": cs2_light},\
	"d2" = {"sound": d2,\
			"colour_key": d2_key,\
			"light_key": d2_light},\
	"eb2" = {"sound": eb2,\
			"colour_key": eb2_key,\
			"light_key": eb2_light},\
	"e2" = {"sound": e2,\
			"colour_key": e2_key,\
			"light_key": e2_light},\
	}

signal key_played

func _ready() -> void:
	key_played.connect(Global.check_key_order)

func _emit_key_played() -> void:
	key_played.emit()

func trigger_piano_key(key:String, play_sound:bool = true) -> void:
	for note in key_dictionary:
		if note == key:
			Global.keys_played.append(key)
			
			if play_sound:
				key_dictionary[note]["sound"].play()
			key_dictionary[note]["colour_key"].show()
			key_dictionary[note]["light_key"].show()
			
			var timer : Timer = Timer.new()
			add_child(timer)
			timer.wait_time = 1.0
			timer.one_shot = true
			timer.start()
			await timer.timeout
			key_dictionary[note]["colour_key"].hide()
			key_dictionary[note]["light_key"].hide()
			timer.queue_free()

func _on_b_0_body_entered(body):
	trigger_piano_key("b0")
	_emit_key_played()

func _on_c_1_body_entered(body):
	trigger_piano_key("c1")
	_emit_key_played()

func _on_cs_1_body_entered(body):
	trigger_piano_key("cs1")
	_emit_key_played()

func _on_d_1_body_entered(body):
	trigger_piano_key("d1")
	_emit_key_played()

func _on_eb_1_body_entered(body):
	trigger_piano_key("eb1")
	_emit_key_played()

func _on_e_1_body_entered(body):
	trigger_piano_key("e1")
	_emit_key_played()

func _on_f_1_body_entered(body):
	trigger_piano_key("f1")
	_emit_key_played()

func _on_fs_1_body_entered(body):
	trigger_piano_key("fs1")
	_emit_key_played()

func _on_g_1_body_entered(body):
	trigger_piano_key("g1")
	_emit_key_played()

func _on_ab_1_body_entered(body):
	trigger_piano_key("ab1")
	_emit_key_played()

func _on_a_1_body_entered(body):
	trigger_piano_key("a1")
	_emit_key_played()

func _on_bb_1_body_entered(body):
	trigger_piano_key("bb1")
	_emit_key_played()

func _on_b_1_body_entered(body):
	trigger_piano_key("b1")
	_emit_key_played()

func _on_c_2_body_entered(body):
	trigger_piano_key("c2")
	_emit_key_played()

func _on_cs_2_body_entered(body):
	trigger_piano_key("cs2")
	_emit_key_played()

func _on_d_2_body_entered(body):
	trigger_piano_key("d2")
	_emit_key_played()

func _on_eb_2_body_entered(body):
	trigger_piano_key("eb2")
	_emit_key_played()

func _on_e_2_body_entered(body):
	trigger_piano_key("e2")
	_emit_key_played()
