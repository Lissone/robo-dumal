extends Area2D

var velocity = Vector2()

export var direction = 1
const SPEED = 200

func _ready():
	$AnimatedSprite.play("shoot")
	
func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	
func set_fireball_direction(dir):
	direction = dir
	
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Fireball_body_entered(body):
	queue_free()
