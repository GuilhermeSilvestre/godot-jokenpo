extends Button

func _pressed():
	Global.SCORE = 0
	get_tree().quit() # Fecha o jogo.
