extends RigidBody2D

@onready var animation = $Gravity/AnimatedSprite2D
var current_asteroid 

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play('default')

func return_position():
	return self.position
func return_force():
	return self.mass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_asteroid :
		#print("Tryingg to apply physics to asteroid")
		current_asteroid.apply_gravity(self.mass,self.position)


func _on_gravity_body_entered(body):
	#print(body," have entered planet gravity")
	if body != self:
		current_asteroid = body


func _on_gravity_body_exited(body):
	current_asteroid = null




func _on_body_entered(body):
	print("B0dy ",body," entered")
