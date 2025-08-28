class_name StatManager
extends Node2D

# What stats?
@export var initStats: Array[Stat] = []
var base_stats: Dictionary = {}
var active_boons: Array[Boon] = []
var final_stats: Dictionary = {}

func _ready() -> void:
	GlobalSignalBus.connect("stat_value_changed", _on_stat_changed_signal)
	#dict setup
	for s in initStats:
		base_stats[s.statType] = s.statValue
	
	var eff1 = BoonEffect.new()
	eff1.stat_type = Stat.StatType.Lives
	eff1.value = 2
	eff1.effect_type = BoonEffect.EffectType.Additive
	
	var eff2 = BoonEffect.new()
	eff2.stat_type = Stat.StatType.MaxBounces
	eff2.value = 2.0
	eff2.effect_type = BoonEffect.EffectType.Multiplicative
	
	var eff3 = BoonEffect.new()
	eff3.stat_type = Stat.StatType.SpikeChance
	eff3.value = 0.0
	eff3.effect_type = BoonEffect.EffectType.Override
	
	var boon1 = Boon.new()
	boon1.name = "Test Boon"
	boon1.duration_levels = -1
	boon1.effects.append(eff1)
	
	var boon2 = Boon.new()
	boon2.name = "Test Boon 2"
	boon2.duration_levels = 1
	boon2.effects.append(eff2)
	
	var boon3 = Boon.new()
	boon3.name = "Test Boon 3"
	boon3.duration_levels = 2
	boon3.effects.append(eff3)
	
	apply_boon(boon1)
	apply_boon(boon2)
	apply_boon(boon3)
	
	print("Applied boons, starting level 1 with: ", final_stats)
	print("Next level (2)")
	advance_level()
	print("Next level (3)")
	advance_level()
	print("Next level (4)")
	advance_level()
	#recalc_stats()
	
func apply_boon(boon: Boon):
	active_boons.append(boon)
	recalc_stats()
	
func recalc_stats():
	#reset base stat to calculate all
	final_stats = base_stats.duplicate()

	#multipliers (start at 1.0 per stat)
	var multipliers: Dictionary = {}
	for k in base_stats.keys():
		multipliers[k] = 1.0

	#overrides (last boon wins)
	var overrides: Dictionary = {}

	#apply boons
	for boon in active_boons:
		for effect in boon.effects:
			match effect.effect_type:
				BoonEffect.EffectType.Additive:
					final_stats[effect.stat_type] += effect.value
				BoonEffect.EffectType.Multiplicative:
					multipliers[effect.stat_type] *= effect.value
				BoonEffect.EffectType.Override:
					overrides[effect.stat_type] = effect.value

	#apply multipliers
	for k in multipliers.keys():
		final_stats[k] *= multipliers[k]

	#apply overrides last
	for k in overrides.keys():
		final_stats[k] = overrides[k]

	print("Final stats: ", final_stats)

func advance_level():
	# Tick down durations
	for boon in active_boons:
		if boon.duration_levels > 0:
			boon.duration_levels -= 1

	active_boons = active_boons.filter(func(b): return b.duration_levels != 0)
	recalc_stats()
	
func _on_stat_changed_signal(stat: Stat, newVal: float) -> void:
	print(Stat.StatType.keys()[stat.statType] + " changed to " + str(stat.statValue))
