extends AudioStreamPlayer

@export var muffled_song : AudioStream
@export var normal_song : AudioStream

func _ready() -> void:
	stream = muffled_song
	play()

func play_muffled() -> void:
	if stream == muffled_song:
		return
	var time : float = get_playback_position()
	time *= 1.33333333333333
	stream = muffled_song
	volume_db = 0
	play(time)
	
	stream = muffled_song

func play_normal() -> void:
	if stream == normal_song:
		return
	var time : float = get_playback_position()
	time *= 0.75
	stream = normal_song
	volume_db = -8
	play(time)
