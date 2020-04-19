extends Button

export(String, FILE) var next_scene_path: = ""

func _on_button_up() -> void:
	PlayerData.difficulty = "easy"
	PlayerData.start_time = OS.get_datetime()
	PlayerData.last_watered_time = PlayerData.start_time
	get_tree().change_scene(next_scene_path)
