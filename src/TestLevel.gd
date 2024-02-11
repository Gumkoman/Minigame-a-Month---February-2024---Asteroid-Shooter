extends Node2D


@onready var asteroidsNode: Node2D = $Asteroids
@onready var asteroids: Array = asteroidsNode.get_children()

@onready var camera: Camera2D = $Camera
var StartingCameraPosition: Vector2 = Vector2(0,2500)
@export var MOUSE_SENSITIVITY : float = 0.5
var dragging : bool = false
var shooting : bool = false
var follow_astreoid : bool = false
var current_asteroid
# Called when the node enters the scene tree for the first time.

func _ready():
	pass
	#for element in asteroids:
		#print(element)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			current_asteroid = check_for_asteroid_collision()
			if current_asteroid != null:
				current_asteroid._on_click()
				shooting = true
			else:
				dragging = true
			
		elif event.button_index == MOUSE_BUTTON_LEFT and event.pressed==false:
			if shooting:
				shooting = false
				shoot_asteroid()
				follow_astreoid = true
			dragging = false
	if event is InputEventMouseMotion and dragging:
		camera.position -= event.relative
	elif event is InputEventMouseMotion and shooting:
		current_asteroid.update_power_line()
	if follow_astreoid :
		if Input.is_action_just_pressed('destroy'):
			follow_astreoid = false
			camera.position = StartingCameraPosition



func check_for_asteroid_collision():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection = space.intersect_point(query,1)
	#print("Intersection:",intersection,intersection[0].collider.position)
	if intersection.size() != 0:
		return intersection[0].collider
	else:
		return null


func shoot_asteroid():
	current_asteroid.shoot()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if follow_astreoid:
		camera.position = current_asteroid.position
		#var space = get_world_2d().direct_space_state
		#var query = PhysicsPointQueryParameters2D.new()
		#query.position = current_asteroid.position
		#var intersection = space.intersect_point(query,1)
		#if intersection.size() != 0:
			#print("flying ",intersection)
		#print(current_asteroid)
		




func _on_planet_input_event(viewport, event, shape_idx):
	print('_on_planet_input_event',event)
