class_name PlayerCamera
extends Camera3D

@export var player : Player

@export var velocity_track_strength : float
@export var follow_curve : Curve

func _ready() -> void:
	position.z = 10.67
	pass

func _physics_process(delta: float) -> void:
	var target : Vector3 = Vector3(player.global_position.x,player.global_position.y,global_position.z)
	target.x += Input.get_axis("move_left","move_right") * 1.5
	
	var dist : float = global_position.distance_to(target)
	print(dist)
	
	if not is_zero_approx(dist):
		
		var travel : float = follow_curve.sample(dist)
		
		global_position = global_position.move_toward(target,travel)
