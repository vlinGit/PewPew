extends Node2D

var enemyScene = preload("res://enemy.tscn")
var hitCache = 0

func getSpawnLoc():
	var section = randi_range(0,3) # 0,1,2,3 -> up, right, down, left
	var spawnLoc = Vector2()
	if section % 2 == 0:
		var x = randf_range(0,1500)
		var y = randf()
		if y < 0.5:
			spawnLoc = Vector2(x, -200)
		else:
			spawnLoc = Vector2(x, 800)
	else:
		var x = randf()
		var y = randf_range(-200, 800)
		if x < 0.5:
			spawnLoc = Vector2(-300, y)
		else:
			spawnLoc = Vector2(1500, y)
	
	return spawnLoc

func _on_spawn_delay_timeout():
	var enemy = enemyScene.instantiate()
	enemy.position = getSpawnLoc()
	add_child(enemy)

func _process(_delta):
	if global.hits % 10 == 0 and global.hits != hitCache:
		var timeout: Timer = get_node("spawnDelay")
		timeout.wait_time /= 2
		hitCache = global.hits
