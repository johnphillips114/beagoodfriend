extends Node

signal watered

var difficulty = "easy" setget set_difficulty
var start_time = OS.get_datetime() setget set_start_time
var last_watered_time = OS.get_datetime()
var life_status = "alive"
var save_dict = {}

func reset() -> void:
	difficulty = "easy"
	start_time = OS.get_datetime()
	last_watered_time = OS.get_datetime()
	
func set_difficulty(value: String) -> void:
	difficulty = value
	
func set_start_time(value: Dictionary) -> void:
	start_time = value
	
func update_last_watered_time() -> void:
	last_watered_time = OS.get_datetime()
	emit_signal("watered")
	save()

func save():
	save_dict = {
		"start_time": start_time,
		"difficulty": difficulty,
		"last_water": last_watered_time,
		"life_status": life_status
	}
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	save_game.store_line(to_json(save_dict))
	save_game.close()
