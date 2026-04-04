class_name PlayerModel
extends Node3D

@export var player : Player
@export var animation_player : AnimationPlayer

var jumping : bool = false

func jump() -> void:
	jumping = true
	animation_player.play("Skeleton|Jump",0.2,1.0)
	await animation_player.animation_finished
	jumping = false

func _physics_process(delta: float) -> void:
	if jumping:
		return
	if not is_zero_approx(player.velocity.x):
		scale.z = 1 if player.velocity.x > 0 else -1
		if player.movement_component.sprinting:
			animation_player.play("Skeleton|Sprint",0.2)
		else:
			animation_player.play("Skeleton|Walk",0.2)
	else:
		animation_player.play("Skeleton|Idle",0.2)
