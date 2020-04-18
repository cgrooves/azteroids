extends RigidBody2D

# Script variables
export (int) var booster_thrust

# Member variables
var left_thrust = 0.0
var right_thrust = 0.0
var forward_thrust = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle the booster limits
	pass

func _unhandled_key_input(event):
	
	if event.is_action("booster_port"):
		left_thrust += booster_thrust
		print("left press")
		
	if event.is_action("booster_stbd"):
		right_thrust += booster_thrust
		print("right press")
		
	if event.is_action("ui_up"):
		forward_thrust += booster_thrust
		print("up press")
	else:
		forward_thrust = 0

func _physics_process(delta):
	apply_central_impulse(Vector2(forward_thrust, self.rotation))
