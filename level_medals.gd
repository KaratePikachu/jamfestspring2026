class_name LevelMedals
extends Resource


const SAVE_PATH : String = "user://medals.tres"


enum Medal{
	NONE,
	BRONZE,
	SILVER,
	GOLD
}

@export var medals : Array[Medal]
@export var best_times : Array[float]

static func load() -> LevelMedals:
	if ResourceLoader.exists(SAVE_PATH):
		return ResourceLoader.load(SAVE_PATH)
	else:
		var new_level_medals : LevelMedals = LevelMedals.new()
		for i in MainMenu.levels:
			new_level_medals.medals.append(Medal.NONE)
			new_level_medals.best_times.append(0.0)
		return new_level_medals

static func save(level_medals : LevelMedals) -> void:
	ResourceSaver.save(level_medals, SAVE_PATH)
