extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
