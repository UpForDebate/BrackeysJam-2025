extends Control

# Boons are resources dragged in the inspector
@export var available_boons : Array[BoonFinal] = []
@export var player_stats : PlayerStats

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

func _on_health_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[0])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("Health Upgrade Added")
	print_debug("Current Health: ", player_stats.stats[0].stat_value)

func _on_speed_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[1])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("Speed Upgrade Added")
	print_debug("Current Speed: ", player_stats.stats[1].stat_value)

func _on_spike_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[2])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("Spikes Upgrade Added")
	print_debug("Current Spikes Chance: ", player_stats.stats[2].stat_value)

func on_ohko_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[3])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("OHKO Upgrade Added")
	print_debug("Current OHKO Value: ", player_stats.stats[3].stat_value)

func on_bounce_pad_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[4])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("Bounce Pads Upgrade Added")
	print_debug("Current Bounce Pads Chance: ", player_stats.stats[4].stat_value)


func on_bounce_pad_big_upgrade_btn_pressed() -> void:
	player_stats.handle_boons(available_boons[5])
	
	# For debugging purposes!
	# This should be called whenever the player finished a level
	player_stats.pass_level() 
	print_debug("Bounce Pads Upgrade Added")
	print_debug("Current Bounce Pads Chance: ", player_stats.stats[4].stat_value)
