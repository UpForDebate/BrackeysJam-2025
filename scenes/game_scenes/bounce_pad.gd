extends RigidBody2D

@export var bounce_force: Vector2 = Vector2(0, -600)  # upwards by default

func _on_rigid_body_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
