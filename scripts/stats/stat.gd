class_name Stat
extends Resource

enum StatType{
	Lives,
	Bounces,
	MaxBounces,
	SpikeChance,
}

@export var statType: StatType
@export var statValue: float :
	get: return statValue
	set(val):
		statValue = val
		GlobalSignalBus.emit_signal("stat_value_changed", self, val)
