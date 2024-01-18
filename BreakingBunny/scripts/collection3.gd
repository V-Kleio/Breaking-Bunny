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
	
	if totalDrugs < 10:
		$Cops.disabled = true
		$"Cops/10".text = "10 Power Ups"
	if totalDrugs < 20:
		$Yotsuba.disabled = true
		$"Yotsuba/20".text = "20 Power Ups"
		 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # Replace with function body.


func _on_left_pressed():
	get_tree().change_scene_to_file("res://scenes/collection2.tscn")


func _on_cops_pressed():
	$CopsCard.show() # Replace with function body.


func _on_yotsuba_pressed():
	$YotsubaCard.show() # Replace with function body.


func _on_cops_card_pressed():
	$CopsCard.hide() # Replace with function body.


func _on_yotsuba_card_pressed():
	$YotsubaCard.hide() # Replace with function body.
