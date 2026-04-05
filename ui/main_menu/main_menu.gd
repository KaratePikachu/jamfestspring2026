class_name MainMenu
extends Node3D

static var levels : Array[String] = [
	"res://level/levels/level_1.tscn",
	"res://level/levels/level_2.tscn",
	"res://level/levels/level_3.tscn",
	"res://level/levels/level_4.tscn",
	"res://level/levels/level_5.tscn"
]

@export var player_model : PlayerModel

var animation_options : Array[StringName] = ["Skeleton|Idle","Skeleton|Walk","Skeleton|Win","Skeleton|Sprint","Skeleton|Lose"]

@onready var main_menu_buttons : VBoxContainer = $CanvasLayer/Control/MainMenuButtons
@onready var level_select_buttons : GridContainer = $CanvasLayer/Control/LevelSelectButtons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_model.animation_player.animation_finished.connect(func(a) -> void:
		#player_model.scale.x *= -1
		#await get_tree().create_timer(1).timeout
		player_model.animation_player.play(animation_options.pick_random(),0.25,2)
	)
	player_model.animation_player.play(animation_options.pick_random(),0.25,2)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_level_select_pressed() -> void:
	main_menu_buttons.hide()
	level_select_buttons.show()

func _on_back_button_pressed() -> void:
	level_select_buttons.hide()
	main_menu_buttons.show()
	


func _on_quit_pressed() -> void:
	get_tree().quit()
