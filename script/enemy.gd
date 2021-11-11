extends KinematicBody2D

var velocity = Vector2()
var is_dead = false

export var direction = 1
export var detects_cliffs = true

func _ready():
	$Sprite.play("walk")
	
	if direction == -1:
		$Sprite.flip_h = true
	
	$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs

func _physics_process(delta):
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$Sprite.flip_h = not $Sprite.flip_h
		$floor_checker.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	if is_dead == false:
		velocity.y += 20
		velocity.x = 50 * direction
		move_and_slide(velocity, Vector2.UP)

func _on_sides_checker_body_entered(body):
	body.ouch()


func _on_sides_checker_area_entered(area):
	is_dead = true
	$Sprite.play("dead")
	
	set_collision_layer_bit(4, false)
	
	$sides_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_mask_bit(6, false)
