extends KinematicBody2D

var stormcloud = 1
var Velocity = Vector2.ZERO
var Maxspeed = 180
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name stormcloud
var Player = load("res://Player.gd")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-5,5)
	Velocity.y += rng.randi_range(-5,5)
	if global_position.y > 0:
		Velocity.y -= 5
	if global_position.y < -6402:
		Velocity.y += 5
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
		if body is Player:
			if $Timer.time_left == 0:
				var bullet = preload("res://Effect.tscn")
				for i in 30:
					var Bullet = bullet.instance()
					Bullet.global_position.x = body.global_position.x + rng.randi_range(-100, 100)
					Bullet.global_position.y = body.global_position.y + rng.randi_range(-100,100)
					Bullet.global_rotation = body.global_rotation
					Bullet.set_as_toplevel(true)
					get_parent().add_child(Bullet)
				body.HP -= 1
				body.Power -= 50
				$Timer.start(0.6)
		if "drone" in body:
			var bullet = preload("res://Effect.tscn")
			var Bullet = bullet.instance()
			Bullet.global_position = body.global_position
			Bullet.global_rotation = body.global_rotation
			Bullet.set_as_toplevel(true)
			get_parent().add_child(Bullet)
			body.Energy = 0
		if "ShooterJet" in body or body is DashJet:
			var bullet = preload("res://Effect.tscn")
			var Bullet = bullet.instance()
			Bullet.global_position = body.global_position
			Bullet.global_rotation = body.global_rotation
			Bullet.set_as_toplevel(true)
			get_parent().add_child(Bullet)
			Manager.Score += 41
			body.queue_free()
