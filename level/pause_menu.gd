extends Panel

func _ready() -> void:
	GameMusic.play_normal()
	hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused == false:
			pause()
		else:
			unpause()

func pause() -> void:
	get_tree().paused = true
	GameMusic.play_muffled()
	show()
	pass

func unpause() -> void:
	get_tree().paused = false
	GameMusic.play_normal()
	hide()
	pass


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://ui/main_menu/main_menu.tscn")
	pass # Replace with function body.


func _on_resume_pressed() -> void:
	unpause()
