extends Node2D

func _ready() -> void:
	Utils.saveGame();
	Utils.loadGame();
func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
