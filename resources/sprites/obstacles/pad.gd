extends Sprite2D

@export var force: Vector2 =  Vector2(-10, -10)
@export var multiplier: float = 10.0
@export var show_debug_gizmo: bool = true

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	if Engine.is_editor_hint():
		queue_redraw()

func _draw():
	var dir = force.normalized() #-transform.y.normalized()
	var length = stat_manager.initStats[4].currentValue * 10
	draw_line(Vector2.ZERO, dir * length, Color.RED, 2.0)

	
func _on_body_entered(body: Node):
	var bounce = force.normalized() * stat_manager.initStats[4].currentValue # -transform.y.normalized() * multiplier 
	if body is PlayerRagdoll :
		print("Collision detected with player")
		print(bounce)
		# body.push_away()
		print(body.name)
		print(body.linear_velocity)
		body.linear_velocity =  body.linear_velocity * force.normalized() * stat_manager.initStats[4].currentValue 
		print(body.linear_velocity)

		# body.apply_central_impulse(bounce)
	elif body.has_method("apply_central_impulse"): 
		pass
		# body.apply_central_impulse(bounce)
	elif "velocity" in body: 
		pass
		# If your player is a CharacterBody2D
		# body.velocity = bounce
