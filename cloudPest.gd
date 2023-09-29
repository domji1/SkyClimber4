extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 500
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name cloudPest
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-30,30)
	Velocity.y += rng.randi_range(-30,30)
	if global_position.y < 2200:
		Velocity.y += 15
	if global_position.y > 6400:
		Velocity.y -= 15
	if global_position.x < -1500:
		Velocity.x += 15
	if global_position.x > 1500:
		Velocity.x -= 15
	if Velocity.x > Maxspeed:
		Velocity.x = Maxspeed
	if Velocity.y > Maxspeed:
		Velocity.y = Maxspeed
	if Velocity.x < -Maxspeed:
		Velocity.x = -Maxspeed
	if Velocity.y < -Maxspeed:
		Velocity.y = -Maxspeed
	if $Timer.time_left == 0:
		Velocity.y += 15 
	move_and_slide(Velocity)
	for body in $Area2D.get_overlapping_bodies():
		if body.get("HP"):
			body.HP -= 1
			queue_free()
		if body is Elektrocloud:
			Manager.Score += 10
			queue_free()
		if body.get("Energy"):
			Manager.Score += 10
			body.Energy -= 5
			queue_free()
		if body.get("pewpew") or body is Elektrocloud:
			Manager.Score += 10
			queue_free()
	
