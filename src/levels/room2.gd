extends Node2D

onready var scene_tree = get_tree()
onready var feed_button: Button = get_node("UserInterface/Button")
onready var obj_sprite: Sprite = get_node("Sprite")
onready var msg_back: ColorRect = get_node("TextureRect/ColorRect")
onready var msg_label: Label = get_node("TextureRect/ColorRect/Label")
onready var curr: Dictionary = OS.get_datetime()
onready var last: Dictionary = PlayerData.last_watered_time
onready var start: Dictionary = PlayerData.start_time

var next_water_time = PlayerData.last_watered_time
var ampm = "AM"


func _ready() -> void:
	msg_back.visible = false
	msg_label.text = ""
	feed_button.visible = false
	feed_button.text = "Feed and pet"
	if (curr['day'] - last['day'] > 1) or (curr['day'] - last['day'] == 1 and curr['hour'] - last['hour'] > 1):
		obj_sprite.frame = 1
		msg_back.visible = true
		msg_label.text = "Unfortunately, the dog has passed away."
	else:
		obj_sprite.frame = 0
		msg_back.visible = false
		msg_label.text = ""
	if (obj_sprite.frame == 0 and ((curr['day'] - start['day'] >= 5) or (curr['month'] - start['month'] >= 1) or (curr['year'] - start['year'] >= 1))):
		msg_back.visible = true
		msg_label.text = "Thanks for looking after Sammy dude, \n you're a real good friend : )"
		feed_button.visible = false
	elif (obj_sprite.frame == 1 and ((curr['day'] - start['day'] >= 5) or (curr['month'] - start['month'] >= 1) or (curr['year'] - start['year'] >= 1))):
		msg_back.visible = true
		msg_label.text = "We can't be friends anymore.\n Please leave."
		feed_button.visible = false


func _on_feed_area_body_entered(body: Node) -> void:
	feed_button.visible = true


func _on_feed_area_body_exited(body: Node) -> void:
	feed_button.visible = false


func _on_Button_button_up() -> void:
		# Check to make sure dog isn't already dead
	if obj_sprite.frame == 0:
		PlayerData.update_last_watered_time()
		feed_button.text = "Woof woof! : )"
		next_water_time = PlayerData.last_watered_time
		next_water_time["hour"]=PlayerData.last_watered_time["hour"]+12
		msg_back.visible = true
		if next_water_time['hour'] > 12:
			ampm = "AM"
		else:
			ampm = "PM"
		msg_label.text = "Make sure to feed and pet \n Sammy again before %s:%s %s!" % [next_water_time['hour']%12, next_water_time['minute'],ampm]
	else:
		feed_button.visible = false
