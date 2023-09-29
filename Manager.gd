extends Node

var Score = 0
var Playerpos = Vector2.ZERO
var clouds = 40
var junk = 10
const ScoreLength = 5
var Jetnumber = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


func GetPrettyScore() -> String:
	var s = str(Score)
	if s.length() < ScoreLength:
		for i in ScoreLength - s.length():
			s = s.insert(0, "0")
	
	return s
