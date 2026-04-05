extends Area3D

@export var level : Level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$Sprite3D.rotate(Vector3.UP,0.02)
	
	for body : Node3D in get_overlapping_bodies():
		if body is Player:
			if body.is_on_floor():
				level.win(body)
	pass
