class_name Level
extends Node3D

#signal time_changed

@export var level_num : int

@export var max_time : float
@export var silver_time : float = 1000
@export var gold_time : float = 1000

@export var player : Player


#@export var gate : Gate

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("kys") and not player.rewind_component.rewinding:
		if player.player_model.winning:
			get_tree().reload_current_scene()
		if is_zero_approx(time_left):
			player.player_model.animation_player.speed_scale = 3
		
		time_left = 0

var time_left : float:
	set(new_val):
		time_left = new_val
		var time_left_label : Label = $CanvasLayer/Control/VBoxContainer/MarginContainer/TextureRect/TimeLeft
		time_left_label.text = str("%.2f" % time_left) + "s"
		#time_changed.emit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().set_auto_accept_quit(false)
	$CanvasLayer/Control/NewRecord.hide()
	if MainMenu.level_medals == null:
		MainMenu.level_medals = LevelMedals.load()
	time_left = max_time
	
	var target_label : Label = $CanvasLayer/Control/VBoxContainer/TargetLabel
	var curr_medal : LevelMedals.Medal = MainMenu.level_medals.medals[level_num-1]
	match curr_medal:
		LevelMedals.Medal.NONE:
			target_label.text = ""
		LevelMedals.Medal.BRONZE:
			target_label.text = "Silver: "+str(silver_time)
		LevelMedals.Medal.SILVER:
			target_label.text = "Gold: "+str(gold_time)
		LevelMedals.Medal.GOLD:
			target_label.text = "Best Time: "+str("%.2f" % MainMenu.level_medals.best_times[level_num-1])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player.rewind_component.rewinding and not player.player_model.winning:
		time_left = move_toward(time_left, 0, delta)
		if is_zero_approx(time_left):
			player.lose()

func win(player : Player) -> void:
	var medal : LevelMedals.Medal = LevelMedals.Medal.BRONZE
	var medal_color : Color = Color.SADDLE_BROWN
	var win_text : String = "Bronze"
	if time_left >= gold_time:
		medal = LevelMedals.Medal.GOLD
		medal_color = Color.GOLD
		win_text = "Gold"
	elif time_left >= silver_time:
		medal = LevelMedals.Medal.SILVER
		medal_color = Color.SILVER
		win_text = "Silver"
	
	if medal > MainMenu.level_medals.medals[level_num-1]:
		MainMenu.level_medals.medals[level_num-1] = medal
	if time_left >= MainMenu.level_medals.best_times[level_num-1]:
		MainMenu.level_medals.best_times[level_num-1] = time_left
		$CanvasLayer/Control/NewRecord/Label.text = "New Record!\n"+str("%.2f" % time_left)
		$CanvasLayer/Control/NewRecord/NewRecordMedal.text = win_text
		$CanvasLayer/Control/NewRecord/NewRecordMedal.add_theme_color_override("font_color",medal_color)
		$CanvasLayer/Control/NewRecord/NewRecordAnimation.play("new_record")
		
	
	LevelMedals.save(MainMenu.level_medals)
	
	if player.player_model.winning:
		return
	player.player_model.win_animation()
	await player.player_model.finished_win_animation
	
	if level_num < MainMenu.levels.size():
		get_tree().change_scene_to_file(MainMenu.levels[level_num])
	else:
		GameMusic.play_muffled()
		get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")

func battery_collected() -> void:
	#if gate != null:
		#gate.open()
	pass

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		LevelMedals.save(MainMenu.level_medals)
		print("aaa")
		get_tree().quit() # default behavior
