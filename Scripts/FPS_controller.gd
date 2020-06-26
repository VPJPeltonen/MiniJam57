extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sens = 0.3
var velocity = Vector3()


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

func _physics_process(delta):
	var head_basis = $Head.get_global_transform().basis
	
	var direction = Vector3()
	if Input.is_action_pressed("move_forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("move_backward"):
		direction += head_basis.z
	
	if Input.is_action_pressed("move_left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("move_right"):
		direction += head_basis.x
	
	direction = direction.normalized()
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = move_and_slide(velocity, Vector3.UP)
