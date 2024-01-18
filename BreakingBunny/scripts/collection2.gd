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
	$VBoxContainer/highScore.text = "High Score: " + str(high_score) # Replace with function body.

	if totalCollectible < 25:
		$Bunny.disabled = true
		$"Bunny/25".text = "25 Collectibles"
	if totalCollectible < 50:
		$Friend.disabled = true
		$"Friend/50".text = "50 Collectibles"
	if totalCollectible < 75:
		$Drugs.disabled = true
		$"Drugs/75".text = "75 Collectibles"
	if totalCollectible < 100:
		$Soda.disabled = true
		$"Soda/100".text = "100 Collectibles"
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # Replace with function body.


func _on_right_pressed():
	get_tree().change_scene_to_file("res://scenes/collection3.tscn") # Replace with function body.


func _on_left_pressed():
	get_tree().change_scene_to_file("res://scenes/collection.tscn")


func _on_bunny_pressed():
	$BunnyCard.show() # Replace with function body.


func _on_friend_pressed():
	$FriendCard.show() # Replace with function body.


func _on_drugs_pressed():
	$DrugsCard.show() # Replace with function body.


func _on_soda_pressed():
	$SodaCard.show() # Replace with function body.


func _on_bunny_card_pressed():
	$BunnyCard.hide() # Replace with function body.


func _on_friend_card_pressed():
	$FriendCard.hide() # Replace with function body.


func _on_drugs_card_pressed():
	$DrugsCard.hide() # Replace with function body.


func _on_soda_card_pressed():
	$SodaCard.hide() # Replace with function body.
