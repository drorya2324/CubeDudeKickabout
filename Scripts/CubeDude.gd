extends KinematicBody

var motion = Vector3()

const UP = Vector3(0,1,0)
const GRAVITY = -5

export var speed = 10

func _physics_process(delta):
	move()
	fall()
	

func _process(delta):
	animate()
	face_forward()

func move():
	if Input.is_action_pressed("P1up") and not Input.is_action_pressed("P1down") :
		motion.z = -1
	elif Input.is_action_pressed("P1down") and not Input.is_action_pressed("P1up") :
		motion.z = 1
	else:
		motion.z = 0
	
	if Input.is_action_pressed("P1left") and not Input.is_action_pressed("P1right") :
		motion.x = -1
	elif Input.is_action_pressed("P1right") and not Input.is_action_pressed("P1left") :
		motion.x = 1
	else: 
		motion.x = 0
	move_and_slide((motion.normalized() * speed),UP)

func fall():
	if is_on_floor():
		motion. y = 0
	else:
		motion.y = GRAVITY
	

func animate():
	if motion.x != 0 or motion.z != 0:
		$AnimationPlayer.play("Arms Cross Walk")

func face_forward():
	if not motion.x == 0 or not motion.z == 0:
		look_at(Vector3(-motion.x,0,-motion.z)*speed,UP)
