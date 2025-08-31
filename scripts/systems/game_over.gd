extends Node

@export var starting_level: String = "res://"

func _on_restart_btn_pressed() -> void:
	get_tree().change_scene_to_file(starting_level)
	stat_manager.reset_stats()
	stat_manager.reset_boons()
	stat_manager.reset_active_boons()


func _on_quit_btn_pressed() -> void:
	get_tree().quit()
