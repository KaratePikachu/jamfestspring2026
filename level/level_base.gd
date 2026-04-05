class_name Level
extends Node3D

#signal time_changed

@export var level_num : int

@export var max_time : float
@export var player : Player

#@export var gate : Gate

var time_left : float:
	set(new_val):
		time_left = new_val
		$CanvasLayer/Control/MarginContainer/TextureRect/TimeLeft.text = str("%.2f" % time_left) + "s"
		#time_changed.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time_left = max_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player.rewind_component.rewinding and not player.player_model.winning:
		time_left = move_toward(time_left, 0, delta)
		if is_zero_approx(time_left):
			player.lose()

func win(player : Player) -> void:
	if player.player_model.winning:
		return
	player.player_model.win_animation()
	await player.player_model.finished_win_animation
	
	if level_num < MainMenu.levels.size():
		get_tree().change_scene_to_file(MainMenu.levels[level_num])
	else:
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func battery_collected() -> void:
	#if gate != null:
		#gate.open()
	pass
