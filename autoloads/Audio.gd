extends Node

var fade_out : bool = false

@onready var toy_music : AudioStreamPlayer = $ToyMusic
@onready var timer : Timer = $Timer

func _process(delta) -> void:
	if fade_out:
		toy_music.volume_db = lerp(toy_music.volume_db, -80.0, 0.8 * delta)
	
		if toy_music.volume_db < -50.0:
			toy_music.volume_db = 0.0
			toy_music.stop()
			fade_out = false

func play_toy_music(music:Resource) -> void:
	toy_music.stream = music
	toy_music.play()
	
	timer.start()
	await timer.timeout
	fade_out = true
