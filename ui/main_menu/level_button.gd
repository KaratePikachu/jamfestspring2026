@tool
extends TextureButton

@export var number : int:
	set(new_val):
		number = new_val
		$Label.text = ">"+str(number)


func _ready() -> void:
	await get_tree().process_frame
	var medal : LevelMedals.Medal = MainMenu.level_medals.medals[number-1]
	match medal:
		LevelMedals.Medal.NONE:
			pass
		LevelMedals.Medal.BRONZE:
			$Label.add_theme_color_override("font_color",Color.SADDLE_BROWN)
		LevelMedals.Medal.SILVER:
			$Label.add_theme_color_override("font_color",Color.SILVER)
		LevelMedals.Medal.GOLD:
			$Label.add_theme_color_override("font_color",Color.GOLD)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	GameMusic.play_normal()
	get_tree().change_scene_to_file(MainMenu.levels[number-1])
