extends Spatial

# what do I need?
# var score_count -> game_over()
#update_GUI()

onready var Ball = $Ball
onready var GreenDude = $Players/GreenCubedude
onready var BlueDude = $Players/BlueCubedude

var P1_score =0
var P2_score =0

export var max_score =5

func ready():
	reset_pitch()


func reset_pitch():
	var BallSpawn = $Spawns/BallSpawn
	Ball.translation = BallSpawn.translation
	get_tree().call_group("Players","reset")
	get_tree().call_group("lights","reset")
	unlock_ball()



func _on_GoalsDetection_body_entered(body, player_id):
	#print ("score for player %s" %player_id)
	$Timer.start()
	update_score(player_id)
	if not $SFX/Airhorn_SFX.is_playing():
		$SFX/Airhorn_SFX.play()
	get_tree().call_group("lights","goal_scored",player_id)
	lock_ball()
	get_tree().call_group("Players","can_move", false)
	get_tree().call_group("Players","emit_particles", player_id)


func unlock_ball():
	Ball.axis_lock_linear_x = false
	Ball.axis_lock_linear_y = false
	Ball.axis_lock_linear_z = false
	Ball.axis_lock_angular_x = false
	Ball.axis_lock_angular_y = false
	Ball.axis_lock_angular_z = false


func lock_ball():
	Ball.axis_lock_linear_x = true
	Ball.axis_lock_linear_y = true
	Ball.axis_lock_linear_z = true
	Ball.axis_lock_angular_x = true
	Ball.axis_lock_angular_y = true
	Ball.axis_lock_angular_z = true


func _on_Timer_timeout():
	reset_pitch()
	$Timer.stop()




func update_score(player):
	var new_score 
	if player ==1:
		P1_score += 1
		new_score = P1_score
	elif player == 2:
		P2_score += 1
		new_score = P2_score
	$GUI.updating(player,new_score)
	
	
	if P1_score == max_score or P2_score==max_score:
		end_game(player)


func end_game(winner):
	$GUI.game_over(winner)


# Being called by GUI
func restart_game():
	get_tree().paused = false
	get_tree().reload_current_scene()



# Pause Game Functions:
#pause Game Key: "P"
func relocate_ball():
	var BallSpawn = $Spawns/BallSpawn
	Ball.translation = BallSpawn.translation
