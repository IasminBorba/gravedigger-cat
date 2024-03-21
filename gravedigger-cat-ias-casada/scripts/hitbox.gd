extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player" and (body.is_attacking_shovel or body.is_attacking_light):
		owner.dead = true
