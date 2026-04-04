class_name Player
extends CharacterBody3D




var internal_velocity : Vector3
var airborne : bool = true

@onready var movement_component : MovementComponent = $MovementComponent
@onready var jump_component : JumpComponent = $JumpComponent
@onready var gravity_component : GravityComponent = $GravityComponent
@onready var rewind_component : RewindComponent = $RewindComponent

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
	
	if is_on_floor() and not rewind_component.ready_to_launch:
		internal_velocity.y = 0
		pass
	else:
		gravity_component.gravity(delta)
	jump_component.process()
	
	movement_component.walk()
	movement_component.decelerate()
	
	if rewind_component.ready_to_launch:
		rewind_component.launch()
	elif rewind_component.rewinding:
		rewind_component.rewind()
	elif rewind_component.recording:
		rewind_component.record_position()
	rewind_component.process()
	
	
	
	velocity = internal_velocity
	#print(velocity)
	move_and_slide()
	
	if is_zero_approx(velocity.x):
		internal_velocity.x = 0
	
	pass
