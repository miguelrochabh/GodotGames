extends KinematicBody2D

const WALK_FORCE = 600
const WALK_MAX_SPEED = 200
const STOP_FORCE = 1300
const JUMP_SPEED = 500

var velocity = Vector2()
var finished = false
var new_stage = false
var flipped = false
var only_right = false
var follow_mouse = false

var walk

var right = "move_right"
var left = "move_left"
var up = "jump"

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	if finished or new_stage or follow_mouse: return
	
	if flipped: for i in range(1): invert_commands()
	
	if only_right: for i in range(1): only_right_commands()
	
	if follow_mouse: for i in range(1): mouse_follower()
	
	walk = WALK_FORCE * (Input.get_action_strength(right) - Input.get_action_strength(left))
	if abs(walk) < WALK_FORCE * 0.2:
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	velocity.y += gravity * delta
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)
	if is_on_floor() and Input.is_action_just_pressed(up):
		velocity.y = -JUMP_SPEED

func _on_Main_finished():
	finished = true

func _on_Main_new_stage():
	finished = false

func _on_Main_inverted_commands():
	flipped = true

func _on_Main_only_right():
	only_right = true
	flipped = false

func _on_Main_cursor_follower():
	follow_mouse = true

func invert_commands():
	if flipped:
			up = "jump"
			left = "move_right"
			right = "move_left"

func only_right_commands():
	flipped = false
	if only_right:
		up = "space"
		left = "a_left"
		right = "d_right"

func mouse_follower():
	follow_mouse = true
	up = "space"
	left = "move_left"
	right = "move_right"
