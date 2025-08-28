extends Sprite2D

@export var next_level: String = "res://"

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

	
func _on_body_entered(body: Node):
	if body is RigidBody2D and body.has_meta("isPlayer"):
		print("Player Collided with Cookie")
		_trigger_win_level()
		
func _trigger_win_level():
	# This needs to be connected to the game manager afterwards
	get_tree().change_scene_to_file(next_level)
