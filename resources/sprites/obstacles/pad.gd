extends Sprite2D

@export var multiplier: float = 10.0
@export var show_debug_gizmo: bool = true

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	var dir = -transform.y.normalized()
	var length = multiplier * 10
	draw_line(Vector2.ZERO, dir * length, Color.RED, 2.0)

	
func _on_body_entered(body: Node):
	var bounce = -transform.y.normalized() * multiplier 
	if body is RigidBody2D and body.has_meta("isPlayer"):
		print("Collision detected with player")
		body.apply_impulse(bounce)
	elif body.has_method("apply_central_impulse"): 
		body.apply_central_impulse(bounce)
	elif "velocity" in body: 
		# If your player is a CharacterBody2D
		body.velocity = bounce
