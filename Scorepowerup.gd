extends KinematicBody2D
var rng = RandomNumberGenerator.new()
var Velocity = Vector2.ZERO
var speed
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	speed = rng.randf_range(50,500)
	Velocity.x = speed
	speed = rng.randf_range(50,500)
	Velocity.y = speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_on_wall():
		Velocity.x = -Velocity.x
	if not $Pickup.playing:	
		move_and_slide(Velocity)


func _on_Area2D_body_entered(body):
	if body is Player:
		Manager.Score += 100
		$Pickup.play()
		hide()
		$CollisionShape2D.disabled = true
		$Area2D.queue_free()


func _on_Pickup_finished():
	queue_free()
