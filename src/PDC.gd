extends ScreenActor


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var collided = false


# Called when the node enters the scene tree for the first time.
func _ready():
	._ready()
	contact_monitor = true
	contacts_reported = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _physics_process(delta):
#	if collided:
#		queue_free()

func _on_body_entered(body):
	queue_free()
