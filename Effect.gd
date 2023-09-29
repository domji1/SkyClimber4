extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spin = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation_degrees += 5
	spin += 20
	if spin == 1000:
		queue_free()
