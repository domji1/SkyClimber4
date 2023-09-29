extends KinematicBody2D

var Velocity = Vector2.ZERO
var Maxspeed = 340
const UP_VECTOR = Vector2(0,-1)
var Power = 600
class_name Player
var HP = 5 setget HPChanged
var Sword = 0
# var a = 2
# var b = "text"
func _ready():
	$Sword.hide()
	$HUD/AnimationPlayer.play("RESET")
	SetupHearts()

func _physics_process(delta):
	if Power < 0:
		Power = 0
	if is_on_wall():
		Velocity.x = 0
	if Input.is_action_pressed("space") and  Power > 0.999:
		Velocity.y -= 26
		Power -= 1
	if Power < 600:
		Power += 0.1
	

	Velocity.y += 20
	for body in $Area2D.get_overlapping_bodies():
		if body is cloud or body is stormcloud or body is junk or body is Satelite:
			if HP > 0:
				Velocity.y = body.Velocity.y -30

	if Input.is_action_pressed("w") and HP > 0:
		for body in $jump.get_overlapping_bodies():
			if body is cloud or body is stormcloud or body is junk or body is Satelite:
				Velocity.y = -1000
				
	if Input.is_action_pressed("d"):
		if Velocity.x < Maxspeed:
			Velocity.x += 80
	if Input.is_action_pressed("a"):
		if Velocity.x > -Maxspeed:
			Velocity.x -= 80
	if Velocity.x < 0:
		Velocity.x += 25
	if Velocity.x > 0:
		Velocity.x -= 25
	if Velocity.x < 25 and Velocity.x > 0 or Velocity.x > -25 and Velocity.x < 0:
		Velocity.x = 0
	if Velocity.x < -1600:
		Velocity.x += 5
	if Velocity.x > 1600:
		Velocity.x -= 5


	move_and_slide(Velocity, UP_VECTOR)
	Manager.Playerpos = global_position
	if is_on_ceiling() or is_on_floor():
		Velocity.y = -5
	$AnimatedSprite2.speed_scale = Power/12.5
	if global_position.y > 7000:
		self.HP -= 1
	$HUD/Score.text = Manager.GetPrettyScore()
	if Sword == 1:
		$Sword.rotation_degrees += 450 * delta
		$Sword.show()
		for body in $Sword/Area2D.get_overlapping_bodies():
			if body.get("Energy"):
				body.Energy = 0
			if body is stormcloud or body is Elektrocloud or body is cloudPest or body is ShooterJet or body is DashJet or body is Asteroid:
				body.queue_free()
				Manager.Score += 10
	if Sword == 0:
		$Sword.hide()
	
		
		






func SetupHearts():
	for i in HP:
		var heart = TextureRect.new()
		heart.texture = load("res://Heart.png")
		heart.name = str(i)
		$HUD/Health.add_child(heart)

func HPChanged(New):
	if New > HP:
		for i in $HUD/Health.get_children():
			i.queue_free()
		for i in New:
			var heart = TextureRect.new()
			heart.texture = load("res://Heart.png")
			heart.name = str(i+1)
			$HUD/Health.add_child(heart)
	elif New < HP:
		for i in HP-New:
			if $HUD/Health.get_child_count() > 0:
				$HUD/Health.get_child(0).queue_free()
	HP = New
	if HP <= 0:
		$HUD/AnimationPlayer.play("Game Over")
		hide()
		$CollisionShape2D.disabled = true
#		$Area2D/CollisionShape2D.disabled = true
#		$Area2D2/CollisionShape2D.disabled = true
		HP = -1000
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Game Over":
		get_tree().change_scene("res://Game.tscn")
		Manager.Score = 0


func _on_Timer_timeout():
	if HP > 0:
		$Timer.start(1)
		Manager.Score += 3

func _on_Timer3_timeout():
	Sword = 0
