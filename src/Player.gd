extends Node2D

var _mouse_input: bool = false
var _mouse_rotation : Vector3
var _rotation_input: float
var _tilt_input : float
@export var MOUSE_SENSITIVITY : float = 0.5
var asteroids : Array[StaticBody2D]
var selected_asteroid : StaticBody2D


var dragging = false
var click_radius = 32 # Size of the sprite.

func _get_selected_asteroid():
	var space = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = get_global_mouse_position()
	var intersection = space.intersect_point(query,1)
	if intersection != null:
		selected_asteroid = intersection[0].collider.on_selection()
	
	
#var state = 'none' 
# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _unhandled_input(event):
	#print(event)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.button_mask == 1:
		dragging = true
		_get_selected_asteroid()
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.button_mask == 0:
		dragging = false
	if event is InputEventMouseMotion and dragging:
		$CameraPivot.position -= event.relative

func mouse_over_asteroid():
	pass
	


func _input(event):
	if event.is_action_pressed('exit'):
		get_tree().quit()
