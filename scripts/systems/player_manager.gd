extends Node
class_name PlayerManager

@export var ui : UIManager
@export var game_over_screen : Control

func handle_player_lives() -> void:
	AudioManager.play_sfx("stab")

	if (stat_manager.initStats[0].currentValue > 0):
		stat_manager.initStats[0].currentValue -= 1
		
	if (stat_manager.initStats[0].currentValue <= 0):
		game_over_screen.visible = true
		get_tree().paused = true
			
	ui.update_ui()
