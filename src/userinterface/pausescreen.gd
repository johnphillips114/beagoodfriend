extends Control


onready var scene_tree: = get_tree()
onready var pause_overlay: ColorRect = get_node("ColorRect")
onready var pausedLabel: Label = get_node("ColorRect/PausedLabel")
onready var daysLabel: Label = get_node("ColorRect/DaysRemainingLabel")
onready var curr: Dictionary = OS.get_datetime()
onready var start: Dictionary = PlayerData.start_time
onready var last: Dictionary = PlayerData.last_watered_time


var daysRemaining = 5
var monthLength = 31
var paused: = false setget set_paused

func _ready() -> void:
	update_interface()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		self.paused = not paused
		scene_tree.set_input_as_handled()

func update_interface() -> void:
	if start['day'] > 23:
		#messy end-of-month calculations
		if start['month'] == 2 and start['year'] % 4 > 0:
			#normal february
			monthLength = 28
		elif start['month'] == 2 and start['year'] % 4 == 0 and start['day'] > 24:
			#leap year february
			monthLength = 29
		elif start['month'] in [4,6,9,11] and start['day'] > 25:
			#30 day months
			monthLength = 30
		elif start['day'] > 26:
			#31 day months
			monthLength = 31
		daysRemaining = 5 - (monthLength % start['day'])
	else:
		daysRemaining = 5 - (curr['day'] - start['day'])
	daysLabel.text = "%s days remaining" % daysRemaining

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value


func _on_ResumeButton_button_up() -> void:
	self.paused = not paused
