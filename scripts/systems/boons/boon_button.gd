extends Control

# Boons are resources dragged in the inspector
@export var available_boons : Array[BoonFinal] = []
@export var canvas : CanvasLayer
@export var level_manager : LevelManager

# Activates the boon menu screen and pauses the game
func _ready() -> void:
	get_tree().paused = true

func _boon_button_on_pressed() -> void:
	for i in range(0, available_boons.size()):
		stat_manager.apply_boon(available_boons[i])

	for i in range(0, available_boons.size()):
		print_debug(available_boons[i].boon_text, " Effect Added")
	
	for s in range(0, stat_manager.initStats.size()):
		print_debug("Current ", stat_manager.initStats[s].StatType.keys()[s] ," Stat: ", stat_manager.initStats[s].currentValue)

	canvas.visible = false;
	get_tree().paused = false
	level_manager.check_spikes()

func _on_pass_level_button_pressed() -> void:
	stat_manager.advance_level()
