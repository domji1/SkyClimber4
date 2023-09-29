extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 180
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name Satelite
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-3,3)
	Velocity.y += rng.randi_range(-3,3)
	if global_position.y < -6400:
		Velocity.y += 5
	if global_position.y > -3180:
		Velocity.y -= 5
	if global_position.x < -1500:
		Velocity.x += 5
	if global_position.x > 1500:
		Velocity.x -= 5
	if Velocity.x > Maxspeed:
		Velocity.x = Maxspeed
	if Velocity.y > Maxspeed:
		Velocity.y = Maxspeed
	if Velocity.x < -Maxspeed:
		Velocity.x = -Maxspeed
	if Velocity.y < -Maxspeed:
		Velocity.y = -Maxspeed
	if is_on_floor() or is_on_ceiling():
		Velocity.y = -Velocity.y
	move_and_slide(Velocity)
	for body in $Area2D.get_overlapping_bodies():
		if body.get("Power"):
			if body.Power < 600:
				body.Power = 600
