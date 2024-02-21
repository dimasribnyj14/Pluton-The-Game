extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -550.0
var lightOff = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var anim_plr

func _ready():
	print(get_tree().current_scene.name)
	anim_plr = get_node("AnimationPlayer")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	#FOURTH LVL
	if lightOff == false:
		if get_tree().current_scene.name == 'FourthLevel':
			if position.x > 0 and $PointLight2D.energy > 0:
				lightOff = true
	elif lightOff == true and $PointLight2D.energy > 0:
		$PointLight2D.energy -= 0.01
	#OTHER
	# Get the input direction and handle the movement/deceleration..;
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_a", "move_d")
	#var tween = get_tree().create_tween()
	if direction == -1:
		#$AnimatedSprite2D.scale = Vector2(1,1)
		$AnimatedSprite2D.flip_h = true
		if $PointLight2D:
			$PointLight2D.scale.x = -5.321
			$PointLight2D.offset.x = 50
		#tween.tween_property($Camera2D, "offset",-200,1)
		#$Camera2D.offset.x = -100
	elif direction == 1:
		#$AnimatedSprite2D.scale = Vector2(-1,1)
		$AnimatedSprite2D.flip_h = false
		if $PointLight2D:
			$PointLight2D.scale.x = 5.321
			$PointLight2D.offset.x = -1
		
		#tween.tween_property($Camera2D, "offset",200,1)
		#$Camera2D.offset.x = 100
		
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			anim_plr.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim_plr.play("idle")


	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			anim_plr.play("jump")
	if position.y >= 1100:
		if get_tree().current_scene.name == 'FirstLevel':
			position.y = -155
			position.x = 275
		elif get_tree().current_scene.name == 'SecondLvl':
			position.y = 170
			position.x = 276
		elif get_tree().current_scene.name == 'ThirdLvl':
			position.y = 1000
			position.x = 276
		elif get_tree().current_scene.name == 'FourthLevel':
			position.y = 667
			position.x = -4436.04
	
	move_and_slide()

	
