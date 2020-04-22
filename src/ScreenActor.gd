extends RigidBody2D
class_name ScreenActor

# Declare member variables here
var screensize = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	screensize = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _integrate_forces(state):
	
	# Screen Teleport
	var transform_origin = state.transform.get_origin()
	
	if transform_origin.x > screensize.x:
		transform_origin.x = 0.0
	elif transform_origin.x < 0.0:
		transform_origin.x = screensize.x
	
	if transform_origin.y > screensize.y:
		transform_origin.y = 0.0
	elif transform_origin.y < 0.0:
		transform_origin.y = screensize.y
	
	state.transform.origin = transform_origin
