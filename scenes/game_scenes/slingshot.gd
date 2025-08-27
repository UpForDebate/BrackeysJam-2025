extends Sprite2D

# Slingshot max size
@export var max_stretch: float = 300.0 

# Projectile prefab and force to launch it
@export var projectile_scene: PackedScene
@export var force_multiplier: float = 10.0  # tweak this for power
@export var spawn_point: Node2D   # drag the SpawnPoint node in the Inspector

# Rubber band effect after releasing slingshot
@export var bounce_time: float = 0.2  # how fast it snaps back
@export var bounce_ease: Tween.EaseType = Tween.EASE_OUT
@export var bounce_trans: Tween.TransitionType = Tween.TRANS_BOUNCE

var start_pos: Vector2
var dragging: bool = false
var pixel_width: float = texture.get_width() * scale.x
var pixel_height: float = texture.get_height() * scale.y
var original_scale: Vector2

func _ready() -> void:
	original_scale = scale 
	
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
				_tween_back()
				
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

func _tween_back():
	var tween = create_tween()
	tween.tween_property(self, "scale", original_scale, bounce_time) \
		.set_ease(bounce_ease).set_trans(bounce_trans)
	tween.tween_property(self, "rotation", 0.0, bounce_time) \
		.set_ease(bounce_ease).set_trans(bounce_trans)
