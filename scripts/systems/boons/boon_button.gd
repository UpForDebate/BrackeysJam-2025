extends Control

# Boons are resources dragged in the inspector
@export var available_boons : Array[BoonFinal] = []
@export var stats_manager : StatManager

var is_active:bool = false:
	set = set_active

# Activates the boon menu when player presses ESC
# This is just for debugging purposes!
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("UpgradeMenuDebug"):
		is_active = !is_active

# Activates the boon menu screen and pauses the game
func set_active(value:bool) ->void:
	is_active = value
	get_tree().paused = is_active
	visible = is_active

func _boon_button_on_pressed() -> void:
	for i in range(0, available_boons.size()):
		stats_manager.apply_boon(available_boons[i])

	for i in range(0, available_boons.size()):
		print_debug(available_boons[i].boon_text, " Effect Added")
	
	for s in range(0, stats_manager.initStats.size()):
		print_debug("Current ", stats_manager.initStats[s].StatType.keys()[s] ," Stat: ", stats_manager.initStats[s].currentValue)

func _on_pass_level_button_pressed() -> void:
	stats_manager.advance_level()
