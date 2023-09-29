extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Velocity.y = rng.randi_range(-100,-120)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.y += 0.02
	move_and_slide(Velocity)
	for body in $Area2D.get_overlapping_bodies():
		if body is Player or body is drone or body is ShooterJet:
			body.Velocity.y = -1800
			Velocity.y = 1000
	
