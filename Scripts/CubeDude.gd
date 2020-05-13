extends KinematicBody

var motion = Vector3()
var can_move = true

const UP = Vector3(0,1,0)
const GRAVITY = -5

export var Player_id = 1
export var speed = 10

func _physics_process(delta):
	if can_move:
		move()
		animate()
	fall()
	

func _process(delta):
	face_forward()

# Being called by Game.gd
func reset():
	var my_spawn = get_tree().get_root().find_node(("Player%sSpawn" %Player_id),true,false)
	translation = my_spawn.translation
	rotation_degrees = my_spawn.rotation_degrees
	can_move = true



func move():
	if Input.is_action_pressed("P%sup" % Player_id) and not Input.is_action_pressed("P%sdown" % Player_id) :
		motion.z = -1
	elif Input.is_action_pressed("P%sdown"% Player_id) and not Input.is_action_pressed("P%sup"% Player_id) :
		motion.z = 1
	else:
		motion.z = 0
	
	if Input.is_action_pressed("P%sleft"% Player_id) and not Input.is_action_pressed("P%sright"% Player_id) :
		motion.x = -1
	elif Input.is_action_pressed("P%sright" %Player_id) and not Input.is_action_pressed("P%sleft"% Player_id) :
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

# Being called by Game.gd
func can_move(value):
	can_move = value
