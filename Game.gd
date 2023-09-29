extends Node2D
var rng = RandomNumberGenerator.new()
var Cloud = preload("res://Cloud.tscn")
var sCloud = preload("res://Spacejunk.tscn")
func _ready():
	Engine.set_target_fps(60)
	rng.randomize()
	for i in 39:
		var CLOUD = Cloud.instance()
		CLOUD.global_position = Vector2(rng.randi_range(-1600, 1600), rng.randi_range(6400, -3180))
		CLOUD.set_as_toplevel(true)
		add_child(CLOUD)
	for i in 10:
		var sCLOUD = sCloud.instance()
		sCLOUD.global_position = Vector2(rng.randi_range(-1600, 1600), rng.randi_range(-6400, -3180 ))
		sCLOUD.set_as_toplevel(true)
		add_child(sCLOUD)
