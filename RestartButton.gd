extends Button

func _on_pressed():
	global.hits = 0
	global.gameOver = false
	get_tree().change_scene_to_file("res://mainScene.tscn")
	
