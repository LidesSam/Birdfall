extends Node

var nextMusicIntro = null
var nextMusicLoop = null
var volume_db=0

var mute = false

# Variable to store the currently playing music box
@export var currentMusicBox:AudioStreamPlayer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initialize the current music box to the first one (musicboxA)
	currentMusicBox = $MusicPlayerA
	
func set_mute(enabled):
	mute=enabled
	if mute:
		$MusicPlayerA.volume_db = -80  # Adjust this value as needed
		$MusicPlayerB.volume_db = -80  # Adjust this value as needed
	else:
		$MusicPlayerA.volume_db = volume_db	
		$MusicPlayerB.volume_db = volume_db
func _process(delta):
	pass

func set_nextmusic(loop):
	print("loop")
	print(loop)
	
	nextMusicIntro = null
	nextMusicLoop = loop

func set_nextmusic_with_intro(intro, loop):
	nextMusicIntro = intro
	nextMusicLoop = loop
	
func set_volume_db(_volume_db = 0.5):
	volume_db=_volume_db
	if mute:
		$MusicPlayerA.volume_db = -80  # Adjust this value as needed
		$MusicPlayerB.volume_db = -80  # Adjust this value as needed
	else:
		$MusicPlayerA.volume_db = volume_db	
		$MusicPlayerB.volume_db = volume_db
	
func switch_to_next_music():
	# Stop the current music
	currentMusicBox.stop()

	# Switch to the next music box
	if currentMusicBox == $MusicPlayerA:
		currentMusicBox = $MusicPlayerB
	else:
		currentMusicBox = $MusicPlayerA
	if(nextMusicIntro!=null):
		currentMusicBox.stream=nextMusicIntro
	else:
		start_loop()
	# Play the next music with intro
	currentMusicBox.play()

# Additional function to handle looping
func start_loop():
	# Stop the current music
	currentMusicBox.stop()

	# Play the next music loop
	currentMusicBox.stream=nextMusicLoop
	if(mute):
		currentMusicBox.volume_db=-80
	else:
		currentMusicBox.volume_db=volume_db
	currentMusicBox.play()


func _on_music_player_finished():
	switch_to_next_music()
	pass # Replace with function body.

func start_play(fadeOn=false,volume_db=0.5):
	print("aloha v_db:",volume_db)
	currentMusicBox.play()
	if mute:
		currentMusicBox.volume_db=-80
	else:
		if fadeOn:
			set_volume_db(volume_db-30)
			var tween = get_tree().create_tween()
			tween.tween_property(currentMusicBox, "volume_db",volume_db, 3)
			tween.tween_callback( set_volume_db.bind(volume_db))
			tween.play()
		
func stop():
	currentMusicBox.stop()
