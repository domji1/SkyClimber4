extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rng = RandomNumberGenerator.new()
var spin = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

func _process(delta):
	if $Timer2.time_left == 0:
		rotation_degrees += 0.4
		spin += 0.4
	if spin == 360:
		spin = 0
		if rng.randf_range(1,2) == 1:
			if rng.randf_range(1,2) == 1:
				$Timer2.start(rng.randi_range(1,120))
	for body in $Area2D.get_overlapping_bodies():
		if $Timer.time_left == 0:
			if body.get("HP"):
				body.HP -= 1
				$Timer.start(2)
		if body.get("Energy"):
			body.Energy = 0
		if body is stormcloud or body is ShooterJet or body is DashJet:
			body.queue_free()
