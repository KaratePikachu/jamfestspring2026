class_name MovementComponent
extends Node

@export var player : Player

@export var grounded_acceleration : float = 2
@export var friction : Curve

func jump_boost() -> void:
	pass

##Movement
func walk() -> void:
	var x_input : float = Input.get_axis("move_left","move_right")
	player.internal_velocity.x += x_input * grounded_acceleration
	


func decelerate() -> void:
	var amount : float = friction.sample(absf(player.velocity.x))
	player.internal_velocity.x = move_toward(player.internal_velocity.x,0,amount)
	print(player.internal_velocity)
