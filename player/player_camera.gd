class_name PlayerCamera
extends Camera3D

@export var player : Player

@export var velocity_track_strength : float
@export var follow_curve : Curve
@export var follow_curve_y : Curve

func _ready() -> void:
	position.z = 10.67
	pass

func process(delta: float) -> void:
	var target : Vector3 = Vector3(player.global_position.x,player.global_position.y,global_position.z)
	target.x += Input.get_axis("move_left","move_right") * 1.5
	
	var dist_x : float = absf(global_position.x-target.x)
	var dist_y : float = absf(global_position.y-target.y)
	
	#print(dist_y)
	
	if not is_zero_approx(dist_x) or not is_zero_approx(dist_y):
		
		var travel_x : float = follow_curve.sample(dist_x)
		var travel_y : float = follow_curve_y.sample(dist_y)
		
		global_position.x = move_toward(global_position.x,target.x,travel_x)
		global_position.y = move_toward(global_position.y,target.y,travel_y)
