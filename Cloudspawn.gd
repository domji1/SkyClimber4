extends Node2D

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.



func _on_Timer_timeout():
	if Manager.clouds < 40:
		var bullet = preload("res://Cloud.tscn")
		var Bullet = bullet.instance()
		Bullet.global_position.y = global_position.y
		Bullet.global_position.x = rng.randf_range(-1500,1500)
		Bullet.global_rotation = global_rotation
		Bullet.set_as_toplevel(true)
		get_parent().add_child(Bullet)
		Manager.clouds += 1
	$Timer.start(6)
