class_name BoonFinal
extends Resource

# ATTENTION! Keep the same order as StatType enum!
# Defines which stat this boon will affect
enum BoonType {
	Lives,
	Bounces,
	MaxBounces,
	SpikeChance,
	PadForce,
	SlingForce,
}

# Which modifier to apply to the stat
enum ModifierType {
	ADDITIVE,
	MULTIPLIER,
	OVERRIDE
}

##TODO: Add texture for the upgrade from resources
@export var boon_text : String = "Lives" # To be used in the UI
@export var boon_type : BoonType
@export var modifier_type : ModifierType

# The modifier to apply to the stat
@export var stat_modifier := 1

# Keep track of the default duration in order to reset 
@export var base_boon_duration := -1

# The amount of levels this boon will be active
# This one is the one to be updated
@export var current_boon_duration := -1; 
