class_name GravityComponent
extends Node

@export var player : Player
@export var gravity_curve : Curve

@export var jump_start : float
@export var fall_start : float

var air_time : float
var grounded : bool

func gravity(delta : float) -> void:
	if not player.is_on_floor():
		if grounded:
			on_fall()
			grounded = false
		
		air_time = clampf(air_time+delta,gravity_curve.min_domain,gravity_curve.max_domain)
	
		
		player.internal_velocity.y -= gravity_curve.sample(air_time)

func on_fall() -> void:
	print("fall")
	air_time = fall_start

func on_jump() -> void:
	print("jump")
	air_time = jump_start
