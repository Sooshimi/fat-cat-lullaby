extends Node

@onready var toy_music : AudioStreamPlayer = $ToyMusic

func play_toy_music(music:Resource) -> void:
	toy_music.stream = music
	toy_music.play()
