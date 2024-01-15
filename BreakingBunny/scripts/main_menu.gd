extends Control



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_game.tscn") # Replace with function body.


func _on_collectibles_button_pressed():
	get_tree().change_scene_to_file("res://scenes/collection.tscn") # Replace with function body.


func _on_setting_button_pressed():
	get_tree().change_scene_to_file("res://scenes/setting.tscn") # Replace with function body.


func _on_exit_button_pressed():
	get_tree().quit() # Replace with function body.
