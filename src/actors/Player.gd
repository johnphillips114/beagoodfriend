extends KinematicBody2D

onready var sprite: Sprite = get_node("Sprite")

var speed: = Vector2(195.0, 180.0)
var _velocity = Vector2.ZERO
var hframe = 0



func _physics_process(_delta: float) -> void:
	var direction = get_direction()
	rotate_sprite(direction)
	_velocity = calculate_move_velocity(_velocity, direction, speed)
	_velocity = move_and_slide(_velocity)


func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var out = linear_velocity
	out = speed * direction
	return out


func rotate_sprite(direction) -> void:
	if direction.x >= direction.y and direction.x >= -1 * direction.y and direction.x > 0:
		hframe = 3
	elif direction.x <= -1 * direction.y and direction.x <= direction.y and direction.x < 0:
		hframe = 1
	elif direction.y < 0:
		hframe = 2
	elif direction.y > 0:
		hframe = 0
	sprite.set_frame(hframe)
