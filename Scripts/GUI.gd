extends CanvasLayer

const BLUE = Color(0.09,0.10,0.90,1)
const GREEN = Color(0.15,0.67,0.18,1)

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS


func _on_PlayAgain_pressed():
	get_parent().restart_game()



func _on_Quit_pressed():
	get_tree().quit()

# Being called by Game.gd (update_score(player))
func updating(player,score):
	print(player , score)
	if player == 1:
		$ScoreBanner/Player1/Score1.text = str(score)
	elif player ==2:
		$ScoreBanner/Player2/Score2.text = str(score)
		
# Being called by Game.gd(end_game())
func game_over(winner):
	print (winner)
	if winner == 1:
		$GameOver/NinePatchRect/VBoxContainer/WinnerLabel.text = "Player 1 Wins!"
		$GameOver/NinePatchRect/VBoxContainer/WinnerLabel.set("custom_colors/font_color",GREEN)
	else:
		$GameOver/NinePatchRect/VBoxContainer/WinnerLabel.text = "Player 2 Wins!"
		$GameOver/NinePatchRect/VBoxContainer/WinnerLabel.set("custom_colors/font_color",BLUE)
	$GameOver.popup_centered()
	get_tree().paused = true

#Pause Game
# Pause Game Key: "P"
func _process(delta):
	if Input.is_action_just_pressed("Pause_Game"):
		get_tree().paused = true
		$PausePopup.popup_centered()
		
func _on_RalocateBallButton_pressed():
	get_tree().call_group("Game","relocate_ball")
	
	
func _on_SoundButton_pressed():
	if BackgroundMusic.playing == false:
		BackgroundMusic.playing = true
		$PausePopup/NinePatchRect/VBoxContainer/SoundButton.text = "sound on"
	else:
		BackgroundMusic.playing = false
		$PausePopup/NinePatchRect/VBoxContainer/SoundButton.text = "sound off"
func _on_Resume_pressed():
	get_tree().paused = false
	$PausePopup.hide()


