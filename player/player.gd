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
	jump_component.process()
	gravity_component.gravity(delta)
	
	movement_component.walk()
	movement_component.decelerate()
	
	velocity = internal_velocity
	move_and_slide()
	pass
