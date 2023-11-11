extends Node2D

@onready var key_c := $KeyCArea/AudioStreamPlayer
@onready var key_d := $KeyDArea/AudioStreamPlayer
@onready var key_e := $KeyEArea/AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_key_c_area_body_entered(body):
	key_c.play()

func _on_key_d_area_body_entered(body):
	key_d.play()

func _on_key_e_area_body_entered(body):
	key_e.play()
