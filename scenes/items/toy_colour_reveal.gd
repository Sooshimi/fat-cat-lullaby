extends Area2D

@export var piano : Node

var keys : Array = ["b0", "c1", "cs1", "d1", "eb1", "e1", "f1", "fs1", "g1", "ab1",\
"a1", "bb1", "b1", "c2", "cs2", "d2", "eb2", "e2"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	piano.trigger_piano_key("", false, 10.0, false, true)
