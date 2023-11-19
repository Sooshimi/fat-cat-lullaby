extends Node

@onready var toy_music : AudioStreamPlayer = $ToyMusic
@onready var game_over_music : AudioStreamPlayer = $GameOverMusic

func play_toy_music(music:Resource) -> void:
	toy_music.stream = music
	toy_music.play()

func play_game_over_music():
	game_over_music.play()
