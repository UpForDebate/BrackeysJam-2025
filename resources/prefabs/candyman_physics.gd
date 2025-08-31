extends RigidBody2D

class_name PlayerRagdoll

func _on_body_entered(body: Node) -> void:
	print("Collision with " + body.name)
#	if body is TileMapLayer:
#co		print("Hit a tilemap at:", global_position)
	AudioManager.play_sfx("hit")


func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	_on_body_entered(body)
