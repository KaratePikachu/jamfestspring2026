class_name Player
extends CharacterBody3D




var internal_velocity : Vector3
var airborne : bool = true

@onready var movement_component : MovementComponent = $MovementComponent
@onready var jump_component : JumpComponent = $JumpComponent
@onready var gravity_component : GravityComponent = $GravityComponent

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
	if is_on_floor():
		internal_velocity.y = 0
	else:
		gravity_component.gravity(delta)
	jump_component.process()
	
	movement_component.walk()
	movement_component.decelerate()
	
	velocity = internal_velocity
	print(velocity)
	move_and_slide()
	pass
