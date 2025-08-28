class_name PlayerStats
extends Node

# The stats the player has
@export var stats : Array[StatTest] = []

# Keeps track of the number of currently active boons
var active_boons : Array[BoonFinal] = []

func _ready() -> void:
	reset_stats()

# Resets all the stats to their default values
func reset_stats() -> void:
	for i in range(0, stats.size()):
		stats[i].stat_value = stats[i].base_stat_value

func handle_boons(active_boon: BoonFinal) -> void:
	reset_stats() # Resets the stats so it doesn't increment on previous ones
	active_boons.append(active_boon)
	
	# Goes through all currently active boons and stats
	# and applies the respective modifier to the corresponding stat
	for boon in active_boons:
		for stat in stats:
			if boon.boon_type == stat.stat_type:
				match boon.modifier_type:
					boon.ModifierType.ADDITIVE:
						stat.stat_value += boon.stat_modifier
					boon.ModifierType.MULTIPLIER:
						stat.stat_value *= boon.stat_modifier
					boon.ModifierType.OVERRIDE:
						stat.stat_value = boon.stat_modifier
	
func pass_level() -> void:
	# Goes through all the active boons and
	# if it has expired, resets its duration
	for boon in active_boons:
		if boon.boon_duration <= 0:
			boon.boon_duration = boon.base_boon_duration
		else: # Otherwise just keep decrementing
			boon.boon_duration -= 1
			break
	
	# Verify if the currently active boon has expired
	# and remove it from the list if it did
	for i in range(active_boons.size() - 1, -1, -1): # Counting backwards so it doesn't get out of bounds
		if active_boons[i].boon_duration == 0:
			active_boons.remove_at(i)
