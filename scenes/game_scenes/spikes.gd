extends Sprite2D

@export var player : PlayerManager

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.has_meta("isPlayer"):
		player.handle_player_lives()
		body.queue_free()
		# Should emit event for the game manager to handle this (score/points, etc)
