class_name Stat
extends Resource

enum StatType{
	Lives,
	Bounces,
	MaxBounces,
	SpikeChance,
	PadForce,
	SlingForce,
}

@export var statType: StatType
@export var baseValue: float

var currentValue: float
