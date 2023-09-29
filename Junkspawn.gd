extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_Timer_timeout():
	if Manager.junk < 10:
		var bullet = preload("res://Spacejunk.tscn")
		var Bullet = bullet.instance()
		Bullet.global_position = global_position
		Bullet.global_rotation = global_rotation
		Bullet.set_as_toplevel(true)
		get_parent().add_child(Bullet)
		Manager.clouds += 1
	$Timer.start(15)

