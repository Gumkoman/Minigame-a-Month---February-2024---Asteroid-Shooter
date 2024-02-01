extends Node2D

var _mouse_input: bool = false
var _mouse_rotation : Vector3
var _rotation_input: float
var _tilt_input : float
@export var MOUSE_SENSITIVITY : float = 0.5

var dragging = false
var click_radius = 32 # Size of the sprite.


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
		print("DRAGGING")
		dragging = true
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.button_mask == 0:
		print("UNDRAGGING")
		dragging = false


	if event is InputEventMouseMotion and dragging:
		# While dragging, move the sprite with the mouse.
		print("Mouse Motion at: ", event.relative)
		$CameraPivot.position -= event.relative

func _input(event):
	if event.is_action_pressed('exit'):
		get_tree().quit()
