extends Sprite2D


func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.has_meta("isPlayer"):
		body.queue_free()
		AudioManager.play_sfx("stab")
		# Should emit event for the game manager to handle this (score/points, etc)
