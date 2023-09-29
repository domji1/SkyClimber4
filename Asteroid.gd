extends KinematicBody2D

var Velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()
class_name Asteroid
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	look_at(Manager.Playerpos)
	rotation_degrees += rng.randi_range(-20,20)
	Velocity = Vector2(1000, 0).rotated(rotation)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_slide(Velocity)


func _on_Area2D_body_entered(body):
	if body.get("Power"):
		body.HP -= 1
		queue_free()
	if body is junk or body is cloud or body is Satelite:
		body.queue_free()
		queue_free()
	if body is bullet or body is Elektrocloud:
		body.queue_free()
		queue_free()
	if body is ShooterJet or body is stormcloud or body is DashJet:
		body.queue_free()
		queue_free()
	if body.get("Energy"):
		body.Energy = 0
		queue_free()
