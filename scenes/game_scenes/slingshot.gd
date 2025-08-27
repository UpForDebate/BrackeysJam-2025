extends Sprite2D

@export var max_stretch: float = 300.0 
@export var projectile_scene: PackedScene
@export var force_multiplier: float = 10.0  # tweak this for power
@export var spawn_point: Node2D   # drag the SpawnPoint node in the Inspector

var start_pos: Vector2
var dragging: bool = false
var pixel_width: float = texture.get_width() * scale.x
var pixel_height: float = texture.get_height() * scale.y

func _launch_projectile():
	var current_pos = get_global_mouse_position()
	var drag_vector = start_pos - current_pos
	
	# Clamp stretch length
	var stretch_length = clamp(drag_vector.length(), pixel_width, max_stretch)
	
	# Direction of launch = opposite of drag
	var launch_dir = drag_vector.normalized()
	var launch_force = launch_dir * stretch_length * force_multiplier
	
	# Instance the projectile
	var projectile = projectile_scene.instantiate() as RigidBody2D
	projectile.position = spawn_point.position	
	get_parent().add_child(projectile)
	
	# Apply impulse at its center of mass
	projectile.apply_impulse(launch_force)
	
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				start_pos = get_global_mouse_position()
				dragging = true
			else:
				if dragging:
					_launch_projectile()
				dragging = false
				scale = Vector2(1, 1) # reset scale if you want
	elif event is InputEventMouseMotion and dragging:
		var current_pos = get_global_mouse_position()
		var drag_vector = start_pos - current_pos
		
		# Length of stretch
		var stretch_length = drag_vector.length()
		stretch_length = clamp(stretch_length, pixel_width, max_stretch)

		# Direction of stretch
		var angle = drag_vector.angle()
		
		# Scale sprite horizontally (assuming sprite points right by default)
		scale.x = stretch_length / texture.get_width()
		
		# Keep Y scale constant
		scale.y = 1
		
		# Rotate to face the mouse drag
		rotation = angle
