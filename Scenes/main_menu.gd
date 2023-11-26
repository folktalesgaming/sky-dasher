extends Node2D

# When the start button is pressed
func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game_play.tscn")

# When the quit button is pressed
func _on_quit_button_pressed():
	get_tree().quit()
