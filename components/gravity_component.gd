class_name GravityComponent
extends Node

@export var player : Player
@export var gravity_curve : Curve

@export var jump_start : float
@export var fall_start : float

var air_time : float
var grounded : bool = false

func gravity(delta : float) -> void:
	if not player.is_on_floor():
		if grounded:
			print("FAALL")
			on_fall()
			grounded = false
		
		air_time = clampf(air_time+delta,gravity_curve.min_domain,gravity_curve.max_domain)
	
		
		player.internal_velocity.y -= gravity_curve.sample(air_time)
	else:
		grounded = true

func on_fall() -> void:
	air_time = jump_start

func on_jump() -> void:
	air_time = jump_start
	grounded = false

func on_double_jump() -> void:
	air_time = fall_start
