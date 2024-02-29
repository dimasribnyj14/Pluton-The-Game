extends CharacterBody2D

#signal healthChanged
#
#
#
#
#var maxHealth = 100
#var currentHealth: int = maxHealth
#var isHurt = false

var knockbackDirection
var can_shoot = true
const SPEED = 350.0
const JUMP_VELOCITY = -550.0
var lightOff = false
@onready var cooldown = $Cooldown
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
##
var anim_plr

func _ready():
	print(get_tree().current_scene.name)
	anim_plr = get_node("AnimationPlayer")


#func hurtByEnemy(area):
	#currentHealth -= 10
	#if currentHealth < 0:
		#currentHealth = maxHealth
		#
	##isHurt = true
	#healthChanged.emit()

	#knockback(area.get_parent().velocity)
	#effects.play("hurtBlink")
	#hurtTimer.start()
	#await hurtTimer.timeout
	#effects.play("RESET")
	#isHurt = false


#func knockback(enemyVelocity: Vector2):
	#knockbackDirection = (enemyVelocity - velocity).normalized() * 3
	#velocity = knockbackDirection
	#move_and_slide()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		if get_tree().current_scene.name == 'Cloudlvl':
			velocity.y += gravity * delta-5
		else:
			velocity.y += gravity * delta
		
		
	#FOURTH LVL
	if get_node_or_null('PointLight2D'):
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
		if get_node_or_null('PointLight2D'):
			$PointLight2D.scale.x = -5.321
			$PointLight2D.offset.x = 50
		$CollisionShape2D.position.x = 70
		#tween.tween_property($Camera2D, "offset",-200,1)
		#$Camera2D.offset.x = -100
	elif direction == 1:
		#$AnimatedSprite2D.scale = Vector2(-1,1)
		$AnimatedSprite2D.flip_h = false
		if get_node_or_null('PointLight2D'):
			$PointLight2D.scale.x = 5.321
			$PointLight2D.offset.x = -1
		$CollisionShape2D.position.x = 37
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

	if Input.is_action_just_pressed("fire"):
		if can_shoot == true:
			var bullet = preload("res://scenes_for_scenes/bullet.tscn").instantiate()
			get_tree().get_root().add_child(bullet)
			can_shoot = false
			bullet.position = position
			bullet.position.y += 60
			#print('plr', position)
			#print('bullet', bullet.position)
			if $AnimatedSprite2D.flip_h == false:
				bullet.speed = 50
				bullet.position.x += 10
			else:
				bullet.speed = -50
				bullet.position.x += -10
			cooldown.start(1)

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
		elif get_tree().current_scene.name == 'Cloudlvl':
			position.y = 966
			position.x = 290
	
	
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(i)
			
			#print(collision.get_collider())
			
			if collision.get_collider().is_in_group("enemy"):
				#hurtByEnemy(collision)
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
				elif get_tree().current_scene.name == 'Cloudlvl':
					position.y = 966
					position.x = 290
			#elif collision.get_collider().is_in_group("interact_break"):
				#$"../Ishere/imag".texture = load('res://resources/interactive/hammer/taken.png')
	
	move_and_slide()


	


	



func _on_cooldown_timeout():
	can_shoot = true
