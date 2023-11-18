extends Area2D

@export var player : CharacterBody2D
@onready var pickup_sound : AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	pickup_sound.play()
	hide()
	get_parent().player_light.texture_scale += 0.3
	get_parent().shadow_light.texture_scale += 0.3
	await pickup_sound.finished
	queue_free()
