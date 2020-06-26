extends KinematicBody

var mouse_sens = 0.3

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event is InputEventMouseMotion:
		#sideways rotation
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		
		#up down rotationt, clamped so you cant look too up or down
		var x_rot = -event.relative.y * mouse_sens
		x_rot = clamp(x_rot,-90,90)
		$Head/Camera.rotate_x(deg2rad(x_rot))
