extends Node2D

onready var audioPlayer = get_node("AudioStreamPlayer2D") as AudioStreamPlayer2D

export var on : bool
export var song1 : AudioStream
export var song2 : AudioStream
export var song3 : AudioStream
export var song4 : AudioStream
export var song5 : AudioStream

var songs : Array

var song : int = 0

func _ready() -> void:
	if song1:
		songs.append(song1)
	if song2:
		songs.append(song2)
	if song3:
		songs.append(song3)
	if song4:
		songs.append(song4)
	if song5:
		songs.append(song5)
	
	
	if songs[0]:
		audioPlayer.stream = songs[0]
	if on:
		audioPlayer.play()

func _on_finished():
	song += 1
	
	if song > songs.size() - 1:
		song = 0
	
	if on:
		if songs[song]:
			audioPlayer.stream = songs[song]
			audioPlayer.play()
	
func _on_interact():
	if on:
		on = false
		audioPlayer.stop()
	else:
		on = true
		audioPlayer.play()
