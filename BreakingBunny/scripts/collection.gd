extends Control

var high_score
var totalCollectible
var totalDrugs


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
	$VBoxContainer/totalCollectible.text = "Total Collectibles: " + str(totalCollectible)
	$VBoxContainer/totalPowerUps.text = "Total Power Ups: " + str(totalDrugs)
	$VBoxContainer/highScore.text = "High Score: " + str(high_score)
	
	if high_score < 10000:
		$Story1.disabled = true
		$"Story1/10k".text = "10K High Score"
	if high_score < 20000:
		$Story2.disabled = true
		$"Story2/20k".text = "20K High Score"
	if high_score < 30000:
		$Gilang.disabled = true
		$"Gilang/30k".text = "30K High Score"
	if high_score < 40000:
		$City.disabled = true
		$"City/40k".text = "40K High Score"
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # Replace with function body.


func _on_right_pressed():
	get_tree().change_scene_to_file("res://scenes/collection2.tscn") # Replace with function body.


func _on_story_1_pressed():
	$Story1Card.show()

func _on_story_1_card_pressed():
	$Story1Card.hide()


func _on_story_2_pressed():
	$Story2Card.show()


func _on_gilang_pressed():
	$GilangCard.show()


func _on_city_pressed():
	$CityCard.show()


func _on_story_2_card_pressed():
	$Story2Card.hide()


func _on_city_card_pressed():
	$CityCard.hide()


func _on_gilang_card_pressed():
	$GilangCard.hide()
