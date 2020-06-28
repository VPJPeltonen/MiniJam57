extends KinematicBody

export var speed = 10
export var acceleration = 5
export var gravity = 0.98
export var jump_power = 30
export var mouse_sens = 0.3

var velocity = Vector3()
var camera_x_rotation = 0

var items_in_range = []
var inventory = []

func _input(event):
	if event is InputEventMouseMotion and MouseCapture.mouse_captured:
		#sideways rotation
		$Head.rotate_y(deg2rad(-event.relative.x * mouse_sens))
		
		#up down rotation
		var x_delta = event.relative.y * mouse_sens
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90: 
			$Head/Camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta


func _physics_process(delta):
	if Input.is_action_just_pressed("activate") and !items_in_range.empty():
		items_in_range[0].player_activate(self)
	
	if Input.is_action_pressed("analyze") and !items_in_range.empty():
		$Analyzer.show_info(items_in_range[0])
		if items_in_range[0].has_item:
			add_item(items_in_range[0].item_held)
	else:
		$Analyzer.hide()
	
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

func add_item(item):
	if inventory.has(item):
		return
	else:
		inventory.append(item)
		$InventoryUI.update_inventory(inventory)

func _on_Interract_Area_body_entered(body):
	if body.has_method("player_activate") and !items_in_range.has(body):
		items_in_range.append(body)
		body.show_activetable()
		
func _on_Interract_Area_body_exited(body):
	if items_in_range.has(body):
		items_in_range.remove(items_in_range.find(body))
		body.hide_activetable()
