extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 800
var rng = RandomNumberGenerator.new()
const UP_VECTOR = Vector2(0,-1)
class_name Elektrocloud



# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Velocity.x += rng.randi_range(-30,30)
	Velocity.y += rng.randi_range(-30,30)
	if global_position.y < 0:
		Velocity.y += 15
	if global_position.y > 3180:
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
	var bullet = preload("res://Effect.tscn")
	var Bullet = bullet.instance()
	Bullet.global_position = global_position
	Bullet.global_rotation = global_rotation
	Bullet.set_as_toplevel(true)
	get_parent().add_child(Bullet)
	move_and_slide(Velocity)
	for body in $Area2D.get_overlapping_bodies():
		if body.get("HP"):
			body.HP -= 1
			body.Power -= 50
			queue_free()
		if body.get("Energy"):
			body.Energy = 0
			Manager.Score += 22
			queue_free()


func _on_Area2D_body_entered(body):
	if body.get("ShooterJet"):
		body.queue_free()
		Manager.Score += 50
		queue_free()
