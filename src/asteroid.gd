extends RigidBody2D

@onready var SelectionSprite = $SpriteSelection
@onready var PowerLine = $Line2D
@onready var cs = $CollisionShape2D

@onready var explosion = $AnimatedSprite2D

var isSelected: bool = false
var isShooting: bool = false
var isFlying: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	SelectionSprite.visible = false
	PowerLine.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func shoot():
	var point_one = PowerLine.get_point_position(0)
	var point_two = PowerLine.get_point_position(1)
	var force = point_one.distance_to(point_two)
	var direction = point_one-point_two
	SelectionSprite.visible = false
	direction = direction.normalized() * 10
	apply_central_impulse(direction*force)
	apply_torque_impulse(randf_range(100.0,1000.0))
	isSelected = false
	isShooting = false
	isFlying = true
	PowerLine.clear_points()
	
	
func _on_click():
	isSelected = !isSelected
	if isSelected:
		SelectionSprite.visible = true
		SelectionSprite.modulate.a = 1
		PowerLine.visible = true
		PowerLine.add_point(get_local_mouse_position(),0)
	else:
		SelectionSprite.visible = false
		SelectionSprite.modulate.a = 1


func update_power_line():
	if PowerLine.get_point_count() > 1 :
		PowerLine.remove_point(1)
	PowerLine.add_point(get_local_mouse_position(),1)
	

func apply_gravity(planet_mass,planet_position):
	#print("applying gravity torward planet with mass of ",planet_mass," on position of",planet_position)
	var distance = planet_position.distance_to(self.position)
	var force = (self.mass * planet_mass)/(distance*distance)
	var direction = planet_position-self.position
	direction = direction.normalized() * 10
	#print("Direction is ",direction," force is ",force, "Applying impulse of ",direction*force*1000)
	apply_central_impulse(direction*force*100)


func destroy_self():
	print("Destoying asteroid ",self)
	explosion.play()







