class_name StatManager
extends Node2D

# What stats?
@export var initStats: Array[Stat] = []
var active_boons: Array[BoonFinal] = []

func _ready() -> void:
	#stats setup
	load_stats()
	reset_stats()

func load_stats() -> void:
	var stat_paths = [
		"res://resources/stats/lives.tres",
		"res://resources/stats/bounces.tres",
		"res://resources/stats/max_bounces.tres",
		"res://resources/stats/spikechance.tres",
		"res://resources/stats/pad_force.tres",
		"res://resources/stats/sling_force.tres",
	]
	
	for path in stat_paths:
		var res: Resource = load(path)
		var stat := Stat.new()
		stat.statType = res.get("statType")
		stat.baseValue = res.get("baseValue")
		initStats.append(stat)

func reset_boons() -> void:
	for b in range(0, active_boons.size()):
		active_boons[b].current_boon_duration = active_boons[b].base_boon_duration

func reset_stats() -> void:
	for s in range(0, initStats.size()):
		initStats[s].currentValue = initStats[s].baseValue

func apply_boon(boon: BoonFinal):
	active_boons.append(boon)
	recalc_stats()
	reset_boons()
	
func recalc_stats():
	#reset base stat to calculate all
	reset_stats()
	
	var additives: Array[BoonFinal] = []
	var multipliers: Array[BoonFinal] = []
	var overrides: Array[BoonFinal] = []
	
	#apply boons
	for boon in active_boons:
		match boon.modifier_type:
			boon.ModifierType.ADDITIVE:
				additives.append(boon)
			boon.ModifierType.MULTIPLIER:
				multipliers.append(boon)
			boon.ModifierType.OVERRIDE:
				overrides.append(boon)
						
	for boon in multipliers:
		handle_boon(boon)
	
	for boon in additives:
		handle_boon(boon)
	
	for boon in overrides:
		handle_boon(boon)

func handle_boon(boon: BoonFinal) -> void:
	for stat in initStats:
		if boon.boon_type == stat.statType:
			match boon.modifier_type:
				boon.ModifierType.ADDITIVE:
					stat.currentValue += boon.stat_modifier
				boon.ModifierType.MULTIPLIER:
					stat.currentValue *= boon.stat_modifier
				boon.ModifierType.OVERRIDE:
					stat.currentValue = boon.stat_modifier

func advance_level():
	# Tick down durations
	for boon in active_boons:
		if boon.current_boon_duration > 0:
			boon.current_boon_duration -= 1
			break
		else: # Otherwise if the boon expired, reset its duration
			boon.current_boon_duration = boon.base_boon_duration

	active_boons = active_boons.filter(func(b): return b.current_boon_duration != 0)
	recalc_stats()
