extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 180
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name cloud
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var num = rng.randf_range(-1, 3.5)
	scale += Vector2(num, num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-5,5)
	Velocity.y += rng.randi_range(-5,5)
	if global_position.y < -3180:
		Velocity.y += 5
	if global_position.y > 6402:
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
	Manager.clouds -= 1
	queue_free()
