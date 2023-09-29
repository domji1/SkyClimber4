extends Node2D

var rng = RandomNumberGenerator.new()
var Cloud = preload("res://hotairballoon.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
	

func _on_Timer_timeout():
	$Timer.start(rng.randf_range(2,32))
	var CLOUD = Cloud.instance()
	CLOUD.global_position.y = global_position.y
	CLOUD.global_position.x = rng.randf_range(-1500,1500)
	CLOUD.set_as_toplevel(true)
	add_child(CLOUD)
