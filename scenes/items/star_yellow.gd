extends Area2D

@export var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	get_parent().player_light.texture_scale += 0.3
	get_parent().shadow_light.texture_scale += 0.3
	queue_free()
