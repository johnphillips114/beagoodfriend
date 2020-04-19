extends Button


export(String, FILE) var next_scene_path: = ""

func _on_button_up() -> void:
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return
		
	save_game.open("user://savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
		var current_line = parse_json(save_game.get_line())
		PlayerData.start_time = current_line["start_time"]
		PlayerData.difficulty = current_line["difficulty"]
		PlayerData.last_watered_time = current_line["last_water"]
		PlayerData.life_status = current_line["life_status"]
	save_game.close()
	if PlayerData.difficulty == "easy":
		get_tree().change_scene("res://src/levels/room1.tscn")
	else:
		get_tree().change_scene("res://src/levels/room2.tscn")
