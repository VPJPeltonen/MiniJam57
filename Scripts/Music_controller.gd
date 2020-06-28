extends AudioStreamPlayer

export(Resource) var finale_music
export(Resource) var alien_music
export(Resource) var time_zero
export(Resource) var time_one
export(Resource) var time_two
export(Resource) var time_three

# Called when the node enters the scene tree for the first time.
func _ready():
	set_stream(time_zero)
	play()

func alien_music():
	set_stream(alien_music)
	play()
