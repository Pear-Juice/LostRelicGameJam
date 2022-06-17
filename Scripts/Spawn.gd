extends Node

var currentSpawnPoint : String
var spawnpoints : Array
var spawnpointNames : Array

func _ready() -> void:
	currentSpawnPoint = "Main"
	spawn()

func spawn():
	initSpawnpoints()
	yield(get_tree().create_timer(.01), "timeout")
	
	var spawnPos = findSpawnPoint(currentSpawnPoint)
	PlayerVariables.move_player(spawnPos)

func initSpawnpoints():
	get_tree().call_group("Spawnpoint", "initialize")
	
func findSpawnPoint(pointName: String) -> Vector2:
	var pos : Vector2
	
	for i in range(0, spawnpoints.size()):
		if (spawnpointNames[i] == pointName):
			pos = spawnpoints[i]
			break
			
	return pos
