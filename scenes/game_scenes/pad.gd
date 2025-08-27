extends Sprite2D

@export var bounce_force: Vector2 = Vector2(0, -600)  # upwards by default
@export var multiplier: float = 10.0

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	var bounce = bounce_force * multiplier 
	if body is RigidBody2D:
		# Should check if it is player (maybe)
		body.apply_impulse(bounce)
	elif body.has_method("apply_central_impulse"): 
		body.apply_central_impulse(bounce)
	elif "velocity" in body: 
		# If your player is a CharacterBody2D
		body.velocity = bounce
