@tool
class_name Battery
extends Area3D

@export var level : Level

var time : float


func _physics_process(delta: float) -> void:
	time += delta
	$Battery.position.y = 0.2*sin(40*deg_to_rad(time))
	$Battery.rotate(Vector3.UP,0.01)


func _on_body_entered(body: Node3D) -> void:
	level.battery_collected()
	hide()
