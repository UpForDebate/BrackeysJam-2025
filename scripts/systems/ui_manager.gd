extends Node
class_name UIManager

@export var lives_txt : Label

func _ready() -> void:
	update_ui()

func update_ui() -> void:
	print_debug("Vidas: ", stat_manager.initStats[0].currentValue)
	lives_txt.text = str(stat_manager.initStats[0].currentValue)
