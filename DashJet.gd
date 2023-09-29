extends KinematicBody2D

var Velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
class_name DashJet
var soundisplaying = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	soundisplaying = false
	if global_position.x < 0:
		global_rotation_degrees = 0
	else:
		global_rotation_degrees = 180
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.x > 1800:
		rotation_degrees = 180
	if global_position.x < -1800:
		rotation_degrees = 0
	if rotation_degrees == 0:
		if Manager.Playerpos.y > global_position.y:
			rotation_degrees += rng.randi_range(0,35)
			if soundisplaying == false:
				print("Playing Dash")
				$Dash.play()
				soundisplaying = true
		else:
			rotation_degrees -= rng.randi_range(0,35)
			if soundisplaying == false:
				print("Playing Dash")
				$Dash.play()
				soundisplaying = true
	if rotation_degrees == 180:
		if Manager.Playerpos.y > global_position.y:
			rotation_degrees -= rng.randi_range(0,35)
		if soundisplaying == false:
			print("Playing Dash")
			$Dash.play()
			soundisplaying = true
		else:
			rotation_degrees += rng.randi_range(0,35)
			if soundisplaying == false:
				print("Playing Dash")
				$Dash.play()
				soundisplaying = true
	for body in $Area2D.get_overlapping_bodies():
		if body.get("Power") and $Timer.time_left == 0:
			body.HP -= 1
			$Timer.start(0.4)
		if body is ShooterJet:
			body.queue_free()
		if body.get("Energy"):
			body.Energy = 0
			queue_free()
		if body is cloudPest or body.get("number"):
			Manager.Score += 5
			body.queue_free()
		if body is bullet or body is Elektrocloud:
			body.queue_free()
			queue_free()
	Velocity = Vector2(3700, 0).rotated(rotation)
	move_and_slide(Velocity)


func _on_Dash_finished():
	soundisplaying = false
