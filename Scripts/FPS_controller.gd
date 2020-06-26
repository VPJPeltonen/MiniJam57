extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sens = 0.3

var velocity = Vector3()
var camera_x_rotation = 0

var item_in_range = null

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		#sideways rotation
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		
		#up down rotationt, clamped so you cant look too up or down
		#var x_rot = -event.relative.y * mouse_sens
		#x_rot = clamp(x_rot,-90,90)
		#$Head/Camera.rotate_x(deg2rad(x_rot))

		var x_delta = event.relative.y * mouse_sens
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90: 
			$Head/Camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
			
func _physics_process(delta):
	if Input.is_action_just_pressed("activate") and item_in_range != null:
		item_in_range.player_activate()
		
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

func _on_Interract_Area_body_entered(body):
	if body.has_method("player_activate"):
		item_in_range = body
		body.show_activetable()
		
func _on_Interract_Area_body_exited(body):
	if item_in_range == body:
		item_in_range = null
		body.hide_activetable()
