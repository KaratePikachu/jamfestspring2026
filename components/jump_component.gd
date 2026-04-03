class_name JumpComponent
extends Node

@export var player : Player
@export var gravity_component : GravityComponent

@export var jump_strength : float
@export var double_jump_strength : float

var has_double_jump : bool = false

func process() -> void:
	
	
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			player.internal_velocity.y = jump_strength
			has_double_jump = true
			gravity_component.on_jump()
		elif has_double_jump:
			has_double_jump = false
			player.internal_velocity.y = double_jump_strength

func double_jump() -> void:
	player.internal_velocity.y = double_jump_strength
