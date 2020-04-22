extends ScreenActor

# Script variables
export (int) var thrust_mag
export (int) var torque_mag

# Member variables
var rotation_direction = 0.0
var thrust = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle the booster limits
	get_input()

func get_input():
	
	# Handle forward thrust
	if Input.is_action_pressed("booster_forward"):
		thrust = Vector2(thrust_mag, 0)
	else:
		thrust = Vector2()
	
	# Handle rotations
	rotation_direction = 0.0
	if Input.is_action_pressed("booster_port"):
		rotation_direction -= 1
	if Input.is_action_pressed("booster_stbd"):
		rotation_direction += 1

##
# Move the character
func _integrate_forces(state):
	add_central_force(thrust.rotated(self.rotation))
	add_torque(rotation_direction * torque_mag)
	
	._integrate_forces(state)
