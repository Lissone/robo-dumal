extends CanvasLayer

var coins = 0
var lifes = 3

func _ready():
	$Coins.text = String(coins)
	$Lifes.text = String(lifes)

func _on_coin_collected():
	$SoundCoinCollect.play()
	coins += 1
	_ready()
	
	if coins == 5:
		get_tree().change_scene("res://scenes/Win.tscn")
		
	
func _on_player_hurts():
	lifes -= 1
	_ready()
	
	if lifes == 0:
		get_tree().change_scene("res://scenes/Lose.tscn")
