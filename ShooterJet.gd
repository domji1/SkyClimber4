extends KinematicBody2D

var ShooterJet = 1
var turn = 0
var Velocity = Vector2.ZERO
var Maxspeed = 600
class_name ShooterJet
var bonus = 0
var pewpew = 0
var rng = RandomNumberGenerator.new()
var number = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Manager.Jetnumber += 1
	number = Manager.Jetnumber
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(Manager.Playerpos)
	Velocity = Velocity + Vector2(7, 0).rotated(rotation)
	if Velocity.length() > Maxspeed:
		Velocity = Maxspeed * Velocity.normalized()
	for body in $Area2D.get_overlapping_bodies():
		if body.get("HP") and $Timer2.time_left == 0:
			body.HP -= 1
			$Timer2.start(1)
		if body is cloudPest:
			body.queue_free()
			Manager.Score += 10
	move_and_slide(Velocity)
		



func _on_Timer_timeout():
	if global_position.distance_to(Manager.Playerpos) < 2000:
		$Fire.play()
		var bullet = preload("res://JetBullet.tscn")
		var Bullet = bullet.instance()
		Bullet.number = number
		Bullet.global_position = global_position
		Bullet.global_rotation = global_rotation
		Bullet.set_as_toplevel(true)
		get_parent().add_child(Bullet)
	$Timer.start(1.6)
