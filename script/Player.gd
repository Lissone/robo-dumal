extends KinematicBody2D

signal player_hurts

var velocity = Vector2()

const MOVE_SPEED = 400
const JUMP_FORCE = 1200
const GRAVITY = 40
const MAX_FALL_SPEED = 1100

const FIREBALL = preload("res://scenes/Fireball.tscn")

func _physics_process(delta): #FPS
	var grounded = is_on_floor()
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = MOVE_SPEED
		$Sprite.play("run")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -MOVE_SPEED
		$Sprite.play("run")
		$Sprite.flip_h = true
	elif Input.is_action_just_pressed("ui_x"):
		$Sprite.play("shoot")
		$ShootSound.play()
		
		var fireball = FIREBALL.instance()
		
		if $Sprite.flip_h == false:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	else:
		velocity.x = 0
		$Sprite.play("idle")
	
	if not grounded: 
		$Sprite.play("jump")
		
	velocity.y += GRAVITY
		
	if grounded and Input.is_action_just_pressed("ui_up"):
		velocity.y = -JUMP_FORCE
		$JumpSound.play()
	
	move_and_slide(velocity, Vector2(0, -1))
	
	if grounded and velocity.y >= 0:
		velocity.y = 150
	
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED

func _on_fallzone_body_entered(body):
	$HurtSound.play()
	get_tree().change_scene("res://scenes/Lose.tscn")
	
func ouch():
	$HurtSound.play()
	set_modulate(Color(1,0.3,0.3,0.5))
	emit_signal("player_hurts")
	
	$Timer.start()
	set_collision_layer_bit(0, false)
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	set_collision_layer_bit(0, true)
