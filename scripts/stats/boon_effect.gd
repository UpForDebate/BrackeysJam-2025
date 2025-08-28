class_name BoonEffect
extends Resource

enum EffectType { Additive, Multiplicative, Override }

@export var stat_type: Stat.StatType
@export var value: float
@export var effect_type: EffectType = EffectType.Additive
