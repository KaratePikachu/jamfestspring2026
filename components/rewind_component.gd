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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("rewind"):
		recording = true
	
	if event.is_action_released("rewind"):
		recording = false
		if rewind_path.curve.point_count >= 2:
			var curve : Curve3D = rewind_path.curve
			
			var launch_dir : Vector3 = curve.get_point_position(1) - curve.get_point_position(0)
			#print(launch_dir)
			#launch_dir.z = 0
			gravity_component.on_fall()
			player.global_position = curve.get_point_position(0)
			player.internal_velocity = launch_dir * 300
			print(player.internal_velocity)
			
		rewind_path.curve.clear_points()

func record_position() -> void:
	rewind_path.curve.add_point(player.global_position)
	
