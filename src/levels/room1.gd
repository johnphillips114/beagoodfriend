extends Node2D

onready var scene_tree = get_tree()
onready var water_button: Button = get_node("UserInterface/Water Button")
onready var obj_sprite: Sprite = get_node("Sprite")
onready var msg_back: ColorRect = get_node("TextureRect/ColorRect")
onready var msg_label: Label = get_node("TextureRect/ColorRect/Label")
onready var curr: Dictionary = OS.get_datetime()
onready var last: Dictionary = PlayerData.last_watered_time
onready var start: Dictionary = PlayerData.start_time

var next_water_time = PlayerData.last_watered_time


func _ready() -> void:
	msg_back.visible = false
	msg_label.text = ""
	water_button.visible = false
	water_button.text = "WATER"
	if (curr['day'] - last['day'] > 1) or (curr['day'] - last['day'] == 1 and curr['hour'] - last['hour'] > 1):
		obj_sprite.frame = 1
		msg_back.visible = true
		msg_label.text = "Unfortuantely, the plant is dead."
	else:
		obj_sprite.frame = 0
		msg_back.visible = false
		msg_label.text = ""
	if (obj_sprite.frame == 0 and ((curr['day'] - start['day'] >= 5) or (curr['month'] - start['month'] >= 1) or (curr['year'] - start['year'] >= 1))):
		msg_back.visible = true
		msg_label.text = "Thanks for looking after my plant dude, \n you're a real good friend : )"
	elif (obj_sprite.frame == 1 and ((curr['day'] - start['day'] >= 5) or (curr['month'] - start['month'] >= 1) or (curr['year'] - start['year'] >= 1))):
		msg_back.visible = true
		msg_label.text = "Duuuuude : ("

func _on_Water_Button_up() -> void:
	# Check to make sure plant isn't already dead
	if obj_sprite.frame == 0:
		PlayerData.update_last_watered_time()
		water_button.text = "Thanks! : )"
		next_water_time = PlayerData.last_watered_time
		next_water_time["day"]=PlayerData.last_watered_time["day"]+1
		msg_back.visible = true
		msg_label.text = "Make sure to water the plant  \n again before tomorrow at \n %s:%s!" % [next_water_time['hour'], next_water_time['minute']]
	else:
		water_button.visible = false


func _on_water_area_body_entered(body: Node) -> void:
	water_button.visible = true


func _on_water_area_body_exited(body: Node) -> void:
	water_button.visible = false
