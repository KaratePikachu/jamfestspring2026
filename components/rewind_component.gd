class_name RewindComponent
extends Node

@export var player : Player
@export var gravity_component : GravityComponent

@export var rewind_path : Path3D
@export var path_follow : PathFollow3D

var recording : bool = false
var rewinding : bool = false

func _ready() -> void:
	assert(rewind_path != null, "Null Rewind Path")

func process() -> void:
	if Input.is_action_just_pressed("rewind"):
		recording = true
	
	if Input.is_action_just_released("rewind"):
		recording = false
		if rewind_path.curve.point_count >= 2:
			var curve : Curve3D = rewind_path.curve
			#gravity_component.on_fall()
			player.global_position = curve.get_point_position(0)
			var launch_dir : Vector3 = curve.get_point_position(0) - curve.get_point_position(1)
			launch_dir = launch_dir.normalized()
			player.internal_velocity = launch_dir*30
			print(launch_dir)
			#launch_dir.z = 0
			#gravity_component.on_fall()
			#player.global_position = curve.get_point_position(0)
			#player.internal_velocity = launch_dir * 30
			#print(player.internal_velocity)
			
		rewind_path.curve.clear_points()

func record_position() -> void:
	var curve : Curve3D = rewind_path.curve
	var num_points : int = curve.point_count
	print(num_points)
	
	var dist : float = player.global_position.distance_squared_to(curve.get_point_position(num_points-1))
	
	if num_points == 0 or not is_zero_approx(dist):
		rewind_path.curve.add_point(player.global_position)
	
