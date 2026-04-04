class_name JumpComponent
extends Node

@export var player : Player
@export var gravity_component : GravityComponent
@export var movement_component : MovementComponent

@export var player_model : PlayerModel

@export var slam_bounce_window : int = 8

@export var slam_jump_strength : float = 11
@export var normal_jump_strength : float = 8

@export var double_jump_strength : float = -15

@export var horizontal_boost_amount : float = 10

var has_double_jump : bool = false
var remaining_bounce_window : int = 0

func process() -> void:
	if remaining_bounce_window > 0:
		remaining_bounce_window -= 1
	
	if player.is_on_floor() and remaining_bounce_window > 0:
		jump(slam_jump_strength)
		grant_jump_boost()
	
	
	if Input.is_action_just_pressed("jump"):
		if player.is_on_floor():
			jump(normal_jump_strength)
		elif has_double_jump:
			double_jump()

func jump(strength : float) -> void:
	player_model.jump()
	player.internal_velocity.y = strength
	has_double_jump = true
	gravity_component.on_jump()

func double_jump() -> void:
	has_double_jump = false
	
	#if player.internal_velocity.y >= 0:
		#player.internal_velocity.y = double_jump_strength
	#else:
	player.internal_velocity.y += double_jump_strength

	gravity_component.on_double_jump()
	remaining_bounce_window = slam_bounce_window
	
func grant_jump_boost() -> void:
	var dir : float = player.internal_velocity.x
	if not is_zero_approx(dir):
		var boost_dir : int = 1 if dir > 0 else -1
		if movement_component.sprinting:
			boost_dir *= 0.3
		player.internal_velocity.x += horizontal_boost_amount * boost_dir
