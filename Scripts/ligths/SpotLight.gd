extends SpotLight

const UP = Vector3(0,1,0)


func _ready():
	reset()
	

# Being called by Game.gd
func goal_scored(player_id):
	var P1 = get_tree().get_root().find_node("GreenCubedude", true, false)
	var P2 = get_tree().get_root().find_node("BlueCubedude", true, false)
	var target
	
	if player_id == 1:
		target = P1.translation
	else:
		target = P2.translation
	
	look_at(target,UP)
	show()
	
	
# Being called by Game.gd
func reset():
	hide()
