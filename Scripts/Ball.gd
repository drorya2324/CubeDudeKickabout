extends RigidBody

func _on_Ball_body_entered(body):
	if body.collision_layer == 4:
		$Cick_SFX.play()
	
