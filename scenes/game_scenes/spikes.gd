extends Sprite2D

@export var ui : UIManager 

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node):
	if body.has_meta("isPlayer"):
		body.queue_free()
		AudioManager.play_sfx("stab")
		
		var lives = stat_manager.initStats[0].currentValue
		
		if (lives > 0):
			stat_manager.initStats[0].currentValue -= 1
			
		ui.update_ui()
		# Should emit event for the game manager to handle this (score/points, etc)
