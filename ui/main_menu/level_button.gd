@tool
extends TextureButton

@export var number : int:
	set(new_val):
		number = new_val
		$Label.text = ">"+str(number)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().change_scene_to_file(MainMenu.levels[number-1])
