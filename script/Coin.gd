extends Area2D

signal coin_collected

func _on_Area2D_body_entered(body):
	emit_signal("coin_collected")
	
	queue_free()

