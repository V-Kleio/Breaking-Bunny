extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
