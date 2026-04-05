class_name Level
extends Node3D

@export var level_num : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func win(player : Player) -> void:
	if player.player_model.winning:
		return
	player.player_model.win_animation()
	await player.player_model.animation_player.animation_finished
	if level_num < MainMenu.levels.size():
		get_tree().change_scene_to_file(MainMenu.levels[level_num])
	else:
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
