extends Node2D

export(String, FILE) var next_scene_path: = ""


func _on_button_up() -> void:
	get_tree().change_scene(next_scene_path)
	get_tree().paused = false