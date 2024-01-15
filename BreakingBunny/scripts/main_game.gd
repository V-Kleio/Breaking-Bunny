extends Node

# Starting position of the bunny
const CHAR_START_POS := Vector2i(160, 376)
const CAM_START_POS := Vector2i(576, 324)

# The speed value of the bunny
var speed: float
const INITIAL_SPEED: float = 5.0 # Initial speed at the start of the game
const MAX_SPEED: int = 15 # Max speed the bunny will run
const SPEED_MODIFIER: int = 5000 # The rate of increase of speed depending on score
var enhanceSpeed: int = 0 # speed for power up

# screen size value for placement
var screenSize: Vector2i
var laneHeight: int

# The score and also the position on x coordinate
var score: int
const SCORE_MODIFIER: int = 5
var high_score

# Obstacles variables
var obstacle1 = preload("res://prefabs/obstacle1.tscn")
var obstacle2 = preload("res://prefabs/obstacle2.tscn")
var obstacleTypes := [obstacle1, obstacle2]
var obstacles: Array
var lastObstacle

# Collectible variables
var collectible1 = preload("res://prefabs/collectible.tscn")
var collectibles: Array
var lastCollectible
var collectibleCounter: int = 0
var totalCollectible

# powerup variables
# Bunny drug
var bunnyDrug = preload("res://prefabs/bunny_drugs.tscn")
var bunnyDrugs: Array
var lastDrug
var drugCounter: int = 0
var totalDrugs

# Some value for the placement of the object
const Y_OFFSET: int = 64
const CLUSTER_DISTANCE: int = 75

# Value for increase obstacle spawn
var difficulty: int
const DIFFICULTY_MODIFIER: int = 10000
const MAX_DIFFICULTY: int = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file!=null:
		high_score = save_file.get_32()
		totalCollectible = save_file.get_32()
		totalDrugs = save_file.get_32()
	else:
		high_score = 0
		totalCollectible = 0
		totalDrugs = 0
		save_game()
	screenSize = get_window().size
	laneHeight = 96
	_start_game()

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)
	save_file.store_32(totalCollectible)
	save_file.store_32(totalDrugs)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	speed = INITIAL_SPEED + (score / SPEED_MODIFIER) + enhanceSpeed
	if speed > MAX_SPEED:
		speed = MAX_SPEED + enhanceSpeed
	difficulty = score / DIFFICULTY_MODIFIER
	if difficulty > MAX_DIFFICULTY:
		difficulty = MAX_DIFFICULTY
		
	_generate_obstacle()
	_generate_collectible()
	_generate_drugs()
	
	$Bunny.position.x += speed
	$Camera2D.position.x += speed
	
	score += speed
	_show_stat()
	
	if ($Camera2D.position.x - $Lane1.position.x) > screenSize.x * 1.5:
		$Lane1.position.x += screenSize.x
		$Lane2.position.x += screenSize.x
		$Lane3.position.x += screenSize.x
	
	for obstacle in obstacles:
		if obstacle.position.x < ($Camera2D.position.x - screenSize.x):
			obstacle.queue_free()
			obstacles.erase(obstacle)
	
	for collectible in collectibles:
		if collectible.position.x < ($Camera2D.position.x - screenSize.x):
			collectible.queue_free()
			collectibles.erase(collectible)
	
	for drug in bunnyDrugs:
		if drug.position.x < ($Camera2D.position.x - screenSize.x):
			drug.queue_free()
			bunnyDrugs.erase(drug)
	if score / SCORE_MODIFIER > high_score:
		high_score = score / SCORE_MODIFIER
	

func _start_game():
	score = 0
	get_tree().paused = false
	
	for obstacle in obstacles:
		obstacle.queue_free()
	obstacles.clear()
	
	for collectible in collectibles:
		collectible.queue_free()
	collectibles.clear()
	
	for drug in bunnyDrugs:
		drug.queue_free()
	bunnyDrugs.clear()
	
	$Bunny.position = CHAR_START_POS
	$Bunny.velocity = Vector2i(0, 0)
	$Camera2D.position = CAM_START_POS
	$Lane1.position = Vector2i(0, -176)
	$Lane2.position = Vector2i(0, -88)
	$Lane3.position = Vector2i(0, 0)
	$GameOver.hide()

func _show_stat():
	$HUD.get_node("Score").text = "SCORE: " + str(score / SCORE_MODIFIER)
	$HUD.get_node("Collectible").text = "Collectible: " + str(collectibleCounter)
	$HUD.get_node("drug").text = "Drug: " + str(drugCounter)
	
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
		
		
func _generate_collectible():
	if collectibles.is_empty():
		var collectible = collectible1.instantiate()
		var collectibleHeight = collectible.get_node("Sprite2D").texture.get_height()
		var collectibleScale = collectible.get_node("Sprite2D").scale
		var collectibleXPos = screenSize.x + score + 1000
		var collectibleYPos = screenSize.y - (laneHeight * randi_range(1, 3) - Y_OFFSET)  - (collectibleHeight * collectibleScale.y / 2)
		lastCollectible = collectible
		_create_collectible(collectible, collectibleXPos, collectibleYPos)

func _create_collectible(collectible, collectibleX, collectibleY):
	collectible.position = Vector2i(collectibleX, collectibleY)
	collectible.body_entered.connect(_collect_collectible)
	add_child(collectible)
	collectibles.append(collectible)
	
func _collect_collectible(body):
	if body.name == "Bunny":
		collectibleCounter += 1
		for collectible in collectibles:
			collectible.visible = false

func _generate_drugs():
	if bunnyDrugs.is_empty():
		var drug = bunnyDrug.instantiate()
		var drugHeight = drug.get_node("Sprite2D").texture.get_height()
		var drugScale = drug.get_node("Sprite2D").scale
		var drugXPos = screenSize.x + score + randi_range(20000, 30000)
		var drugYPos = screenSize.y - (laneHeight * randi_range(1, 3) - Y_OFFSET)  - (drugHeight * drugScale.y / 2)
		lastDrug = drug
		_create_drug(drug, drugXPos, drugYPos)

func _create_drug(drug, drugX, drugY):
	drug.position = Vector2i(drugX, drugY)
	drug.body_entered.connect(_enable_drug)
	add_child(drug)
	bunnyDrugs.append(drug)
	
func _enable_drug(body):
	if body.name == "Bunny":
		drugCounter += 1
		for drug in bunnyDrugs:
			drug.visible = false
		$Bunny.collision_layer = 2
		$Bunny.get_node("Sprite2D").animation = "drugPower"
		enhanceSpeed = 15
		$Timer.start()
		$Timer.timeout.connect(_drug_end)

func _drug_end():
	$Bunny.get_node("Sprite2D").animation = "default"
	enhanceSpeed = 0
	await get_tree().create_timer(1).timeout
	$Bunny.collision_layer = 1

func _game_over():
	totalCollectible += collectibleCounter
	totalDrugs += drugCounter
	$GameOver/GameOverHud.set_score(score / SCORE_MODIFIER)
	$GameOver/GameOverHud.set_highscore(high_score)
	save_game()	
	get_tree().paused = true
	$GameOver.show()
