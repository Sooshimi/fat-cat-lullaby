extends Control

@onready var left_eye : TextureRect = $TextureRect/MarginContainer/HBoxContainer/LeftEye
@onready var middle_eye : TextureRect = $TextureRect/MarginContainer/HBoxContainer/MiddleEye
@onready var right_eye : TextureRect = $TextureRect/MarginContainer/HBoxContainer/RightEye

var ab = load("res://assets/ui/cat_eyes/CatEye_Ab.png")
var a = load("res://assets/ui/cat_eyes/CatEye_A.png")
var bb = load("res://assets/ui/cat_eyes/CatEye_Bb.png")
var b = load("res://assets/ui/cat_eyes/CatEye_B.png")
var cs = load("res://assets/ui/cat_eyes/CatEye_Cs.png")
var c = load("res://assets/ui/cat_eyes/CatEye_C.png")
var d = load("res://assets/ui/cat_eyes/CatEye_D.png")
var eb = load("res://assets/ui/cat_eyes/CatEye_Eb.png")
var e = load("res://assets/ui/cat_eyes/CatEye_E.png")
var fs = load("res://assets/ui/cat_eyes/CatEye_Fs.png")
var f = load("res://assets/ui/cat_eyes/CatEye_F.png")
var g = load("res://assets/ui/cat_eyes/CatEye_G.png")

var i : int = 0

@onready var key_dictionary : Dictionary =\
	{"b0":b, "c1":c, "cs1":cs, "d1":d, "eb1": eb, "e1":e, "f1":f, "fs1":fs,\
	"g1":g, "ab1":ab, "a1":a, "bb1":bb, "b1":b, "c2":c, "cs2":cs, "d2":d,\
	"eb2":eb, "e2":e}

func trigger_eyes(key:String):
	for note in key_dictionary:
		if key == note:
			i += 1
			if i == 1:
				left_eye.texture = key_dictionary[note]
			elif i == 2:
				middle_eye.texture = key_dictionary[note]
			elif i == 3:
				right_eye.texture = key_dictionary[note]
				i = 0
