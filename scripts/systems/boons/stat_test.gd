class_name StatTest
extends Resource

# ATTENTION! Keep the same order as BoonType enum!
# Defines what this stat is for later comparison
enum StatType {
	HEALTH,
	SPEED,
	SPIKES,
	OHKO,
	BOUNCEPADS
}

@export var stat_type: StatType

# Keeps track of the default stat value in order to reset 
@export var base_stat_value : float 

# The current value of this stat
@export var stat_value : float
