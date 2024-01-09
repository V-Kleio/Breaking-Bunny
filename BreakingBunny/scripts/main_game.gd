extends Node


const CHAR_START_POS := Vector2i(160, 376)
const CAM_START_POS := Vector2i(576, 324)

var speed: float
const INITIAL_SPEED: float = 5.0
const MAX_SPEED: int = 15
const SPEED_MODIFIER: int = 5000

var screenSize: Vector2i
var laneHeight: int

var score: int
const SCORE_MODIFIER: int = 5

var obstacle1 = preload("res://prefabs/obstacle1.tscn")
var obstacle2 = preload("res://prefabs/obstacle2.tscn")
var obstacleTypes := [obstacle1, obstacle2]
var obstacles: Array
var lastObstacle
const Y_OFFSET: int = 64
const CLUSTER_DISTANCE: int = 75

var difficulty: int
const DIFFICULTY_MODIFIER: int = 10000
const MAX_DIFFICULTY: int = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_window().size
	laneHeight = 96
	$GameOver.get_node("Button").pressed.connect(_start_game)
	_start_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = INITIAL_SPEED + (score / SPEED_MODIFIER)
	if speed > MAX_SPEED:
		speed = MAX_SPEED
	difficulty = score / DIFFICULTY_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY
		
	_generate_obstacle()
	
	$Bunny.position.x += speed
	$Camera2D.position.x += speed
	
	score += speed
	_show_score()
	
	if ($Camera2D.position.x - $Lane1.position.x) > screenSize.x * 1.5:
		$Lane1.position.x += screenSize.x
		$Lane2.position.x += screenSize.x
		$Lane3.position.x += screenSize.x
	
	for obstacle in obstacles:
		if obstacle.position.x < ($Camera2D.position.x - screenSize.x):
			obstacle.queue_free()
			obstacles.erase(obstacle)

func _start_game():
	score = 0
	get_tree().paused = false
	
	for obstacle in obstacles:
		obstacle.queue_free()
	obstacles.clear()
	
	$Bunny.position = CHAR_START_POS
	$Bunny.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Lane1.position = Vector2i(0, -176)
	$Lane2.position = Vector2i(0, -88)
	$Lane3.position = Vector2i(0, 0)
	$GameOver.hide()

func _show_score():
	$HUD.get_node("Score").text = "SCORE: " + str(score / SCORE_MODIFIER)
	
func _generate_obstacle():
	if obstacles.is_empty() or lastObstacle.position.x < score + randi_range(400, 600):
		var selectObstacle = obstacleTypes[randi() % obstacleTypes.size()]
		var maxObstacle = difficulty + 1
		for i in range(randi() % maxObstacle + 1):
			var obstacle = selectObstacle.instantiate()
			var obstacleHeight = obstacle.get_node("Sprite2D").texture.get_height()
			var obstacleScale = obstacle.get_node("Sprite2D").scale
			var obstacleXPos = screenSize.x + score + 100 + (i * ((difficulty + 1) * CLUSTER_DISTANCE))
			var obstacleYPos = screenSize.y - (laneHeight * randi_range(1, 3) - Y_OFFSET)  - (obstacleHeight * obstacleScale.y / 2)
			lastObstacle = obstacle
			_create_obstacle(obstacle, obstacleXPos, obstacleYPos)
			

func _create_obstacle(obstacle, obstacleX, obstacleY):
	obstacle.position = Vector2i(obstacleX, obstacleY)
	obstacle.body_entered.connect(_hit_obstacle)
	add_child(obstacle)
	obstacles.append(obstacle)

func _hit_obstacle(body):
	if body.name == "Bunny":
		_game_over()
		
func _game_over():
	get_tree().paused = true
	$GameOver.show()
