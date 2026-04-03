class_name MovementComponent
extends Node

@export var player : Player

@export var walk_acceleration : float = 2
@export var friction : Curve
@export var sprint_friction : Curve

var sprinting : bool = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("sprint"):
		player.internal_velocity.x *= 0.3
		sprinting = true
	
	if event.is_action_released("sprint"):
		player.internal_velocity.x *= 0.3
		sprinting = false

func jump_boost() -> void:
	pass

##Movement
func walk() -> void:
	var x_input : float = Input.get_axis("move_left","move_right")
	player.internal_velocity.x += x_input * walk_acceleration



func decelerate() -> void:
	var amount : float = 100000
	if sprinting: 
		amount = sprint_friction.sample(absf(player.velocity.x))
	else:
		amount = friction.sample(absf(player.velocity.x))
	player.internal_velocity.x = move_toward(player.internal_velocity.x,0,amount)
	#print(player.internal_velocity)
