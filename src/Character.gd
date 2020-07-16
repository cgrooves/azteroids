extends ScreenActor

# Script variables
export (int) var thrust_mag
export (int) var torque_mag
export (int) var firing_frame_delay
export (int) var pdc_power

onready var pdc = preload("res://src/PDC.tscn")

# Member variables
var rotation_direction = 0.0
var thrust = Vector2(0,0)
var firing = false
var firing_frames = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Handle the booster limits
	get_input()
	
	# handle firing
	if firing and firing_frames == firing_frame_delay:
		# instance the PDC
		var new_pdc = pdc.instance()
		
		# move the round to the ship's offset
#		new_pdc.global_position = get_node("PDC_cannon").position
		new_pdc.position = get_node("PDC_cannon").global_position
		new_pdc.rotation = self.rotation
		# give it an impulse
		var pdc_impulse = thrust + Vector2(pdc_power, 0).rotated(self.rotation)
		new_pdc.apply_central_impulse(pdc_impulse)
		
		# parent the pdc
		get_parent().add_child(new_pdc)
		
		# reset the firing counter
		firing_frames = 0

func get_input():
	
	# Handle forward thrust
	if Input.is_action_pressed("booster_forward"):
		thrust = Vector2(thrust_mag, 0).rotated(self.rotation)
	else:
		thrust = Vector2(0,0)
	
	# Handle rotations
	rotation_direction = 0.0
	if Input.is_action_pressed("booster_port"):
		rotation_direction -= 1
	elif Input.is_action_pressed("booster_stbd"):
		rotation_direction += 1
	else:
		rotation_direction = 0
		
	
	# Handle firing
	if Input.is_action_pressed("fire"):
		firing = true
		firing_frames += 1
	elif Input.is_action_just_released("fire"):
		firing = false
		# reset timer
		
func _physics_process(delta):
	
	add_central_force(thrust)
	add_torque(rotation_direction * torque_mag)
