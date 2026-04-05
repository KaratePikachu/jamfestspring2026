extends Area3D

@export var level : Level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	
	for body : Node3D in get_overlapping_bodies():
		if body is Player:
			if body.is_on_floor() and not body.player_model.winning:
				$Gate.open()
				level.win(body)
				
	pass
