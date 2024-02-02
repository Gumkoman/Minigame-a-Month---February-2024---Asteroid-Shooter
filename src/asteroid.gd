extends StaticBody2D

@onready var SelectionSprite = $SpriteSelection
var isSelected: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	SelectionSprite.visible = false

func on_selection():
	if isSelected:
		isSelected = false
		SelectionSprite.visible = false
	elif isSelected == false:
		isSelected = true
		SelectionSprite.visible = true	 
	print("selected asteroid")
