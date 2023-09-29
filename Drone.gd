extends KinematicBody2D

var drone
var turn = 0
var Energy = 100
var Velocity = Vector2.ZERO
var Maxspeed = 750
class_name drone
var bonus = 0
var rng = RandomNumberGenerator.new()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Energy = rng.randf_range(80,120)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	turn += Energy / 8
	
	look_at(Manager.Playerpos)
	Velocity = Velocity + Vector2(Energy/2.8, 0).rotated(rotation)
	if Velocity.length() > Maxspeed:
		Velocity = Maxspeed * Velocity.normalized()
	Velocity.y += 15
	for body in $Area2D.get_overlapping_bodies():
		if body is Player and $Timer2.time_left == 0:
			body.HP -= 1
			$Timer2.start(0.6)
			
		if body is stormcloud or body is ShooterJet or body is Satelite:
			body.queue_free()
			Energy -= 1
		if body is cloud or body is junk:
			body.die()
			Energy -= 1
	global_rotation_degrees = turn
	move_and_slide(Velocity)
	if Energy == 0:
		Maxspeed = 1500
		if bonus == 0:
			bonus = 1
			Manager.Score += 50
func _on_Timer_timeout():
	if Energy > 0:
		Energy -= 1
	$Timer.start(1)

