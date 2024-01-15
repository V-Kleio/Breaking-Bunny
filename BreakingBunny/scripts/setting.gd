extends Control

@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
var MUSIC_BUS_VOLUME = 1
var SFX_BUS_VOLUME = 1

func _ready():
	$BGM.value = db_to_linear(AudioServer.get_bus_volume_db(MUSIC_BUS_ID))
	$SFX.value = db_to_linear(AudioServer.get_bus_volume_db(SFX_BUS_ID))


func _on_back_button_pressed():

	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") # Replace with function body.


func _on_bgm_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < .05)



func _on_sfx_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)
