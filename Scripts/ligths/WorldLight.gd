extends DirectionalLight

func _ready():
	reset()


# Being called by Game.gd
func goal_scored(player_id):
	$AnimationPlayer.play("dim")


# Being called by Game.gd
func reset():
	light_energy = 1
