extends Area3D

static var last_hit : int = 0

func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		print(Time.get_unix_time_from_system()-last_hit)
		last_hit = Time.get_unix_time_from_system()
