class_name RewindComponent
extends Node


@export var player : Player
@export var gravity_component : GravityComponent

@export var player_model : PlayerModel

@export var rewind_path : Path3D
@export var path_follow : PathFollow3D

@export var rewind_cooldown_frames : int = 60

var remaining_rewind_cooldown : float = 0
var recording : bool = false
var rewinding : bool = false
var ready_to_launch : bool = false
var ghost_trail : Array[PlayerModel] = []

var og_position : Vector3
var launch_vector : Vector3

func _ready() -> void:
	assert(rewind_path != null, "Null Rewind Path")


func process() -> void:
	
	#if ghost_trash.size() > 0 and randi_range(0,100) > 70:
		#var next_freed : PlayerModel = ghost_trash.pop_back()
		#next_freed.queue_free()
		
	if remaining_rewind_cooldown > 0:
		remaining_rewind_cooldown -= 1
	
	if not rewinding and Input.is_action_just_pressed("rewind") and remaining_rewind_cooldown == 0:
		recording = true
		og_position = player.global_position
		launch_vector = player.velocity.normalized().rotated(Vector3.FORWARD,deg_to_rad(180))
	elif recording and ( Input.is_action_just_released("rewind") or ghost_trail.size() > 30 ):
		recording = false
		rewinding = true
		var num_points : int = rewind_path.curve.point_count
		#print(num_points)
		
		var curve : Curve3D = rewind_path.curve
		launch_vector *= clampf(5*rewind_path.curve.point_count,0,30)
		
		if num_points >= 2:
			path_follow.progress_ratio = 1
			#
			#remote_transform.remote_path = player.get_path()
			
			var tween : Tween = get_tree().create_tween()
			tween.set_trans(Tween.TRANS_EXPO)
			tween.set_ease(Tween.EASE_IN)
			tween.tween_property(path_follow,"progress_ratio",0,1.5)
			await tween.finished
		
		
		gravity_component.on_jump()
		gravity_component.grounded = false
		ready_to_launch = true
		remaining_rewind_cooldown = rewind_cooldown_frames
		rewinding = false

func rewind() -> void:
	player.internal_velocity = Vector3.ZERO
	player.global_position = path_follow.global_position
	var curve : Curve3D = rewind_path.curve
	if float(ghost_trail.size()*2.0+1.5)/curve.point_count > path_follow.progress_ratio: #total points
		var removal : PlayerModel = ghost_trail.pop_back()
		if removal != null:
			#removal.hide()
			removal.queue_free()
		
func launch() -> void:
	player.global_position = og_position
	player.internal_velocity = launch_vector
	rewind_path.curve.clear_points()
	
	
	while ghost_trail.size() > 0:
		var next_thing : PlayerModel = ghost_trail.pop_back()
		next_thing.queue_free()
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
		
	if num_points / 2 > ghost_trail.size():
		var new_model : PlayerModel = player_model.duplicate()
		new_model.player = null
		new_model.become_white()
		new_model.position = player.position
		player.add_sibling(new_model)
		ghost_trail.append(new_model)
	
