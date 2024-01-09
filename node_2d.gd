extends Node2D

var enemyScene = preload("res://enemy.tscn")

func getSpawnLoc():
	var section = randi_range(0,3) # 0,1,2,3 -> up, right, down, left
	var spawnLoc = Vector2()
	if section % 2 == 0:
		var x = randf_range(0,1500)
		var y = randf()
		if y < 0.5:
			spawnLoc = Vector2(x, 500)
		else:
			spawnLoc = Vector2(x, -800)
	else:
		var x = randf()
		var y = randf_range(0, 600)
		if x < 0.5:
			spawnLoc = Vector2(-500, y)
		else:
			spawnLoc = Vector2(1500, y)
	
	return spawnLoc

func _on_spawn_delay_timeout():
	var enemy = enemyScene.instantiate()
	enemy.position = getSpawnLoc()
	add_child(enemy)
