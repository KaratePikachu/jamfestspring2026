class_name JumpComponent
extends Node

@export var player : Player
@export var gravity_component : GravityComponent

@export var buffer_frames : int = 8

@export var jump_strength : float = 11
@export var double_jump_strength : float = -15

@export var horizontal_boost_amount : float = 15

var has_double_jump : bool = false
var remaining_buffer : int = 0

func process() -> void:
	if remaining_buffer > 0:
		remaining_buffer -= 1
	
	
	
	if Input.is_action_just_pressed("jump") or remaining_buffer > 0:
		if player.is_on_floor():
			if remaining_buffer > 0:
				print("WAVEDASH")
				grant_jump_boost()
			jump()
			remaining_buffer = 0
		elif has_double_jump:
			double_jump()
			remaining_buffer = 0
		elif remaining_buffer == 0:
			remaining_buffer = buffer_frames

func jump() -> void:
	player.internal_velocity.y = jump_strength
	has_double_jump = true
	gravity_component.on_jump()

func double_jump() -> void:
	has_double_jump = false
	
	if player.internal_velocity.y >= 0:
		player.internal_velocity.y = double_jump_strength
	else:
		player.internal_velocity.y += double_jump_strength

	gravity_component.on_double_jump()

func grant_jump_boost() -> void:
	var dir : float = player.internal_velocity.x
	if not is_zero_approx(dir):
		var boost_dir : int = 1 if dir > 0 else -1
		player.internal_velocity.x += horizontal_boost_amount * boost_dir
