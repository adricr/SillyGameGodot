extends Node3D
var health:int


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead():
		hide()
	else:
		pass	

func is_dead():
	var is_dead:bool = false
	if self.health <= 0:
		is_dead = true
	return is_dead
	