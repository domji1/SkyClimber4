extends KinematicBody2D

class_name bullet
var ACCEL = 1400
var MAXSPEED = 1400
var Velocity = Vector2.ZERO
var HP = 10
var number = 0


func _physics_process(delta):
	Velocity = Velocity + Vector2(ACCEL, 0).rotated(rotation)
	if Velocity.length() > MAXSPEED:
		Velocity = MAXSPEED * Velocity.normalized()
		
	Velocity = move_and_slide(Velocity)
	for body in $Area2D.get_overlapping_bodies():
		if body.get("HP"):
			body.HP -= 1
			queue_free()
		if body.get("Energy"):
			body.Energy = 0
		if body.get("stormcloud") or body is Elektrocloud or body is cloudPest:
			body.queue_free()
			queue_free()
		if body.get("number"):
			if body.number == number:
				pass
			else:
				Manager.Score += 50
				body.queue_free()
				queue_free()
	if global_position.distance_to(Manager.Playerpos) > 5000:
		queue_free()
