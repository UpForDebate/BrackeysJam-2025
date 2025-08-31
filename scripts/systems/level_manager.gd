extends Node
class_name LevelManager

func check_spikes() -> void:
	if stat_manager.initStats[3].currentValue == 0:
		remove_spikes()

func remove_spikes() -> void:
	for spike in get_tree().get_nodes_in_group("spikes"):
		spike.queue_free()
