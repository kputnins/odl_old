extends Node2D

# Set fullscreen
#func _ready():
#	var root = get_node("/root")
#	root.connect("size_changed",self,"resize")
#	OS.set_window_fullscreen(true)
#	set_process_input(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Handler ESC to exit app
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
