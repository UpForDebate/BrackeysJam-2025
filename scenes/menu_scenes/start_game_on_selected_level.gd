extends Button

# For now just start at level one

func _on_start_game_pressed():
	AppGlobal.game_controller.change_gui_scene("res://scenes/game_scenes/first_level.tscn", true)
