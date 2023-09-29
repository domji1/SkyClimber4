extends Node2D

var moved = 0
var direct = 1
var rng = RandomNumberGenerator.new()
var Cloud = preload("res://HPpowerup.tscn")
var aCloud = preload("res://Powerpowerup.tscn")
var bCloud = preload("res://Scorepowerup.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if direct == 1:
		global_position.x += 10
		moved += 10
	if direct == 2:
		global_position.x -= 10
		moved -= 10
	if moved == 2500:
		direct = 2
	if moved == 0:
		direct = 1


func _on_Timer_timeout():
	$Timer.start(rng.randf_range(15,30))
	var bCLOUD = bCloud.instance()
	bCLOUD.global_position = global_position
	bCLOUD.set_as_toplevel(true)
	add_child(bCLOUD)
