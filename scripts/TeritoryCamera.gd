extends Camera2D

var CAMERA_MOVE_SPEED = 1000
var CAMERA_ZOOM_SPEED = 10

#func _ready():
#	pass


func _process(delta):
	# Hanlde camera movement
	if Input.is_action_pressed("ui_left") || Input.is_key_pressed(KEY_A):
		global_position += Vector2.LEFT * delta * zoom * CAMERA_MOVE_SPEED
	if Input.is_action_pressed("ui_right") || Input.is_key_pressed(KEY_D):
		global_position += Vector2.RIGHT * delta * zoom * CAMERA_MOVE_SPEED
	if Input.is_action_pressed("ui_up") || Input.is_key_pressed(KEY_W):
		global_position += Vector2.UP * delta * zoom * CAMERA_MOVE_SPEED
	if Input.is_action_pressed("ui_down") || Input.is_key_pressed(KEY_S):
		global_position += Vector2.DOWN * delta * zoom * CAMERA_MOVE_SPEED

	# Handle camera zoom
	if Input.is_action_just_released("zoom_in"):
		var new_zoom = delta * zoom.x * CAMERA_ZOOM_SPEED
		zoom.x = clamp(zoom.x - new_zoom, 0.05, 10)
		zoom.y = clamp(zoom.y - new_zoom, 0.05, 10)
	elif Input.is_action_just_released("zoom_out"):
		var new_zoom = delta * zoom.x * CAMERA_ZOOM_SPEED
		zoom.x = clamp(zoom.x + new_zoom, 0.05, 3)
		zoom.y = clamp(zoom.y + new_zoom, 0.05, 3)
