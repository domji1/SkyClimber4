extends Node2D

var spawn = 0

export var score = 125
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Manager.Score > score and spawn == 0:
		var bullet = preload("res://ShooterJet.tscn")
		var Bullet = bullet.instance()
		Bullet.global_position = global_position
		Bullet.global_rotation = global_rotation
		Bullet.set_as_toplevel(true)
		get_parent().add_child(Bullet)
		spawn = 1

