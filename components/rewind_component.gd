class_name RewindComponent
extends Node

@export var player : Player
@export var gravity_component : GravityComponent

@export var rewind_path : Path3D
@export var path_follow : PathFollow3D

var recording : bool = false
var rewinding : bool = false
var ready_to_launch : bool = false

var og_position : Vector3
var launch_vector : Vector3

func _ready() -> void:
	assert(rewind_path != null, "Null Rewind Path")

func process() -> void:
	if Input.is_action_just_pressed("rewind"):
		recording = true
		og_position = player.global_position
		launch_vector = player.internal_velocity.rotated(Vector3.FORWARD,deg_to_rad(180)).normalized()
	elif Input.is_action_just_released("rewind"):
		recording = false
		
		var num_points : int = rewind_path.curve.point_count
		rewinding = true
		var curve : Curve3D = rewind_path.curve
		launch_vector *= clampf(5*rewind_path.curve.get_baked_length(),0,30)
		
		if num_points >= 2:
			path_follow.progress_ratio = 1
			#
			#remote_transform.remote_path = player.get_path()
			
			var tween : Tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_EXPO)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(path_follow,"progress_ratio",0,1)
			await tween.finished
		
		
		gravity_component.on_jump()
		gravity_component.grounded = false
		print("internal vel ", player.internal_velocity)
		ready_to_launch = true
		rewinding = false

func rewind() -> void:
	player.internal_velocity = Vector3.ZERO
	player.global_position = path_follow.global_position

func launch() -> void:
	player.global_position = og_position
	player.internal_velocity = launch_vector
	rewind_path.curve.clear_points()
	ready_to_launch = false

func record_position() -> void:
	var curve : Curve3D = rewind_path.curve
	var num_points : int = curve.point_count
	var should_add_point : bool = false
	#print(num_points)
	
	if num_points == 0:
		should_add_point = true
	else:
		var dist : float = player.global_position.distance_squared_to(curve.get_point_position(num_points-1))
		if dist > 0.1:
			should_add_point = true
	
	if should_add_point:
		rewind_path.curve.add_point(player.global_position)
	
