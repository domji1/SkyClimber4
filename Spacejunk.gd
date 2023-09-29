extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 180
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name junk
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-3.5,3.5)
	Velocity.y += rng.randi_range(-3.5,3.5)
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
	
func die():
	Manager.junk -= 1
	queue_free()
