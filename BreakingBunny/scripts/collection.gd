extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
