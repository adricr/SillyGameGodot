extends Node3D
@export var health:int = 5
var Wood = preload("res://Scenes/wood.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_dead() && self.visible:
		hide()
		var wood1 = Wood.instantiate()
		var wood2 = Wood.instantiate()
		var wood3 = Wood.instantiate()
		wood1.position = position + Vector3(0,0,0)
		wood2.position = position + Vector3(0,1,0)
		wood2.rotation += Vector3(0.26,0,0) 
		wood3.position = position + Vector3(0,2,0)
		get_parent().add_child(wood1)
		get_parent().add_child(wood2)
		get_parent().add_child(wood3)
		queue_free()
		print("hola")
	else:
		pass	

func is_dead():
	var is_dead:bool = false
	if self.health <= 0:
		is_dead = true
	return is_dead
	