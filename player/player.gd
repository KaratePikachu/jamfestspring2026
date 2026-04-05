class_name Player
extends CharacterBody3D




var internal_velocity : Vector3
var airborne : bool = true

var losing : bool = false

@onready var player_model : PlayerModel = $PlayerModel
@onready var movement_component : MovementComponent = $MovementComponent
@onready var jump_component : JumpComponent = $JumpComponent
@onready var gravity_component : GravityComponent = $GravityComponent
@onready var rewind_component : RewindComponent = $RewindComponent


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	if player_model.winning or losing:
		internal_velocity.x = 0
		gravity(delta)
		velocity = internal_velocity
		move_and_slide()
		return
	
	$PlayerCamera.process(delta)
	
	gravity(delta)
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
	
	#print(internal_'velocity)
	#print(rewind_component.creation_count)
	#assert(rewind_component.creation_count == rewind_component.ghost_trail.size())
	velocity = internal_velocity
	#print(velocity)
	move_and_slide()
	
	movement_component.wall_tech()
	
	pass

func gravity(delta : float) -> void:
	if rewind_component.rewinding or rewind_component.ready_to_launch:
		gravity_component.on_jump()
	elif is_on_floor():
		internal_velocity.y = max(0,internal_velocity.y)
		pass
	else:
		gravity_component.gravity(delta)

func lose() -> void:
	if losing or player_model.winning:
		return
	
	losing = true
	player_model.lose_animation()
	await player_model.animation_player.animation_finished
	get_tree().reload_current_scene()
