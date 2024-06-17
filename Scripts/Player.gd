## Ahora mismo se puede mirar alrededor pulsando alt, el jugador se movera con respecto a la direccion del cuerpo, no la camara
# Hay que encontrar la manera de que el cuello mire hacia delante cuando se suelte alt
extends CharacterBody3D

@export var mouse_sensitivity_y = 0.01
@export var mouse_sensitivity_x = 0.01
const SPEED = 2.75
const JUMP_VELOCITY = 2.3
@onready var neck := $Neck
@onready var camera := $Neck/Camera3D
@onready var body := $Pivot/Character
var direction
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# Function to handle mouse movement (still to finish)
func _unhandled_input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)
	elif event is InputEventMouseMotion:
		if Input.is_action_pressed("look"):
			neck.rotate_y(-event.relative.x * mouse_sensitivity_y)
			camera.rotate_x(event.relative.y * mouse_sensitivity_x)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50),deg_to_rad(60))
			neck.rotation.y = clamp(neck.rotation.y, deg_to_rad(-160),deg_to_rad(160))
		else:
			rotate_y(-event.relative.x * mouse_sensitivity_y)
			camera.rotate_x(event.relative.y * mouse_sensitivity_x)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-50),deg_to_rad(60))
		

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#Handle direction
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	#Problemas rotando el cuerpo con la mirada
	#direction = $Neck/Camera3D/Lookat.transform.origin - self.transform.origin
	#print(direction)

func _process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_right", "move_left", "move_back", "move_forward")
	direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#hay que encontrar la manera de hacer que cuando se suelte el alt el cuello mire hacia delante 
	#if Input.is_action_just_released("look"):