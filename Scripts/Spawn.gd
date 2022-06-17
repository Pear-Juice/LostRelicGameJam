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
	var foundPointName : String
	
	for i in range(0, spawnpoints.size()):
		if (spawnpoints[i][0] == pointName):
			foundPointName = spawnpoints[i][0]
			pos = spawnpoints[i][1]
			break
			
	print("Teleport to: " + foundPointName + "  " + str(pos))
	return pos
