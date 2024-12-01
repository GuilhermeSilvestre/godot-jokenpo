extends Button

func _pressed():
	#Go to game
	get_tree().change_scene_to_file("res://Scenes/game.tscn")
