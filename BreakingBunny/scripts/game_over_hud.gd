extends Control


func _on_retry_pressed():
	$ButtonClicked.play()
	await $ButtonClicked.finished
	get_tree().reload_current_scene()

func _on_back_to_menu_pressed():
	$ButtonClicked.play()
	await $ButtonClicked.finished
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)

func set_highscore(value):
	$Panel/HighScore.text = "High Score: " + str(value)
