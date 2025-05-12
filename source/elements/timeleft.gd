extends Control

@onready var started =false
func  _process(delta: float) -> void:
	$Label.text = str("%03d" % round($Timer.time_left))


func start():
	$Timer.start()
	started=true
func stop():
	$Timer.stop()
	started=true

func add_secs(sec := 60):
	var remaining = $Timer.time_left
	if $Timer.is_stopped():
		remaining = $Timer.wait_time  # fallback to full time if stopped
	$Timer.wait_time = remaining + sec
	$Timer.start()
	
func timeout():
	return $Timer.time_left<=0 and started==true

func add_score_and_stop():
	var points= floor(100* $Timer.time_left)
	Global.add_score(points)
	stop()
