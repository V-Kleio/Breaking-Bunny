extends Control


func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_back_to_menu_pressed():
	pass

func set_score(value):
	$Panel/Score.text = "Score: " + str(value)

func set_highscore(value):
	$Panel/HighScore.text = "High Score: " + str(value)
