extends Node2D

var rng = RandomNumberGenerator.new()
var Cloud = preload("res://Elektrocloud.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
	

func _on_Timer_timeout():
	$Timer.start(1)
	if rng.randi_range(1,115) == 1:
		var CLOUD = Cloud.instance()
		CLOUD.global_position.x = global_position.x
		CLOUD.global_position.y = rng.randf_range(3180,0)
		CLOUD.set_as_toplevel(true)
		add_child(CLOUD)
