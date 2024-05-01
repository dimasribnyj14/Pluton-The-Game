extends CharacterBody2D
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
var rng = RandomNumberGenerator.new()
#-168
#17093
@export var checkpointDLC = false
@export var code = int(rng.randf_range(100000, 999999))
signal healthChanged
signal killed
@export var checkpoint = false
@export var place = ""#$CanvasLayer/HBoxContainer2/Place
@export var date = ""#$CanvasLayer/HBoxContainer2/Date
var canEffect = true
@export var crystalValue = 0
@export var checkpointCold = false
@export var checkpointLast = false
@onready var gos = $CanvasLayer/GameOverScreen
var heroSkin
@onready var effects = $Effects
@onready var hurtCD = $HurtCD
var doubleJump = true
@onready var doubleJumpCD = $doubleJump
@onready var diescreen = $CanvasLayer/GameOverScreen
var crouching = false
@export var knockbackPower: int = 500
@export var takenKey = false
@export var maxHealth = 5
var currentHealth: int = maxHealth
@export var takenBoom = false
#var canDmg = true
var inEffect = false
@export var takenHammer = false
var knockbackDirection
var can_shoot = true
const SPEED = 350.0
const JUMP_VELOCITY = -550.0
var lightOff = false
@onready var cooldown = $Cooldown
@onready var anim_plr = get_node("AnimationPlayer")
@export var no_gv = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$CanvasLayer/HBoxContainer2/Place.text = place
	if get_tree().current_scene.name != 'Ship':
		$CanvasLayer/HBoxContainer2/Date.text = date
	
	
	if get_tree().current_scene.name != 'graylvl':
		heroSkin = config.get_value('saves', 'skin')
	else:
		heroSkin = 'dlc'
	
	crystalValue = config.get_value("saves",'crystal')
	effects.play("RESET")
	#killed.connect(await _on_character_killed)
	


#11215


#Sounds
@onready var sfxDeath = get_node('Death')
@onready var sfxFootstep = get_node('Footstep')
@onready var sfxJump = get_node('Jump')
@onready var sfxLaser = get_node('Laser')



@onready var bullet = preload("res://scenes_for_scenes/bullet.tscn")
	

#func removeWall(col):
	#col.get_node('Hammer').visible = false
	

func _physics_process(delta):
	#sfxFootstep.connect("finished", Callable(self,"_on_loop_sound").bind(sfxFootstep))
	if $AnimatedSprite2D.flip_v == true:
		velocity.y += gravity * -delta
	
	# Add the gravity.
	if not is_on_floor():
		if get_tree().current_scene.name == 'Cloudlvl':
			velocity.y += gravity * delta-5
		elif get_tree().current_scene.name == 'last_lvl' and checkpointLast:
			velocity.y += gravity * delta-8
		else:
			if $AnimatedSprite2D.flip_v == false:
				velocity.y += gravity * delta
	else:
		doubleJump = true
		
	#FOURTH LVL
	if get_node_or_null('PointLight2D'):
		if lightOff == false:
			if get_tree().current_scene.name == 'FourthLevel':
				if position.x > 0 and $PointLight2D.energy > 0:
					lightOff = true
		elif lightOff == true and $PointLight2D.energy > 0:
			#$Camera2D/TouchScreenButton.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton5.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton2.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton3.modulate = Color('f9002f')
			#$Camera2D/TouchScreenButton4.modulate = Color('f9002f')
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
		$hurtBox/CollisionShape2D2.position.x = 70
		#tween.tween_property($Camera2D, "offset",-200,1)
		#$Camera2D.offset.x = -100
	elif direction == 1:
		#$AnimatedSprite2D.scale = Vector2(-1,1)
		$AnimatedSprite2D.flip_h = false
		if get_node_or_null('PointLight2D'):
			$PointLight2D.scale.x = 5.321
			$PointLight2D.offset.x = -1
		$CollisionShape2D.position.x = 37
		$hurtBox/CollisionShape2D2.position.x = 37
		#tween.tween_property($Camera2D, "offset",200,1)
		#$Camera2D.offset.x = 100
		
	
	if direction and not crouching:
		
		if not is_on_floor() and $AnimatedSprite2D.flip_v != true or not is_on_ceiling() and $AnimatedSprite2D.flip_v == true: 
			#print("freak")
			sfxFootstep.stop()
		if not inEffect:
			velocity.x = direction * SPEED
		if is_on_floor() and $AnimatedSprite2D.flip_v != true or is_on_ceiling() and $AnimatedSprite2D.flip_v == true:
			if sfxFootstep.playing == false:
				sfxFootstep.play()
			if heroSkin == "default":
				anim_plr.play("run")
			else:
				anim_plr.play("move-%s"%heroSkin)
	else:
		sfxFootstep.stop()
		if not inEffect:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor() or is_on_ceiling() and $AnimatedSprite2D.flip_v == true:
			$CollisionShape2D.rotation_degrees = 0
			$hurtBox/CollisionShape2D2.rotation_degrees = 0
			crouching = false
			if inEffect == false:
				if heroSkin == "default":
					anim_plr.play("idle")
				else:
					anim_plr.play("idle-%s"%heroSkin)
	
	if Input.is_action_just_pressed('effect') and canEffect and get_tree().current_scene.name == 'graylvl':
		#if is_on_floor():
		canEffect = false
		inEffect = true
		$hurtBox.set_collision_layer_value(1,false)
		$hurtBox.set_collision_mask_value(1,false)
			
		anim_plr.play("effect")
		for i in 50:
				
			if $AnimatedSprite2D.flip_h == false:
				if i != 0:
					velocity.x = (10000/i)
				#else:
					#velocity.x = (i*10)
			else:
				if i != 0:
					velocity.x = -(10000/i)#(100/i)
				#else:
					#velocity.x = -(i*10)#100
			await get_tree().create_timer(0.001).timeout
			#anim_plr.play("effect")
		$hurtBox.set_collision_layer_value(1,true)
		$hurtBox.set_collision_mask_value(1,true)
		inEffect = false
		await get_tree().create_timer(3).timeout
		canEffect = true
	
	if Input.is_action_pressed("crouch") and not config.get_value("options",'doublejump'):
		if is_on_floor() or is_on_ceiling() and $AnimatedSprite2D.flip_v == true:
			#direction = 0
			crouching = true
			$CollisionShape2D.rotation_degrees = 90
			$hurtBox/CollisionShape2D2.rotation_degrees = 90
			if heroSkin == "default":
				anim_plr.play("lay")
			else:
				anim_plr.play("lay-%s"%heroSkin)
	
	if Input.is_action_just_pressed("fire"):
		if can_shoot == true:
			if heroSkin == 'dlc':
				for i in range(3):
					sfxLaser.play()
					var bullet_instance = bullet.instantiate()
			#if get_tree().current_scene.name == 'SecondLvl':
				#get_node('/root/SecondLvl').add_child(bullet_instance)
			#else:
				#get_tree().get_root().add_child(bullet_instance)
					get_tree().current_scene.add_child(bullet_instance)
					can_shoot = false
					bullet_instance.position = position
			#$Camera2D.position = bullet.position
					bullet_instance.position.y += 60
			#if $CollisionShape2D.rotation_degrees == 90:
				#bullet_instance.position.y += 0
			#print('plr', position)
			#print('bullet', bullet.position)
					if $AnimatedSprite2D.flip_h == false:
						bullet_instance.speed = 50
						bullet_instance.position.x += 10
					else:
						bullet_instance.speed = -50
						bullet_instance.position.x += -10
					cooldown.start(1.5)
					await get_tree().create_timer(0.1).timeout
			else:
				sfxLaser.play()
				var bullet_instance = bullet.instantiate()
			#if get_tree().current_scene.name == 'SecondLvl':
				#get_node('/root/SecondLvl').add_child(bullet_instance)
			#else:
				#get_tree().get_root().add_child(bullet_instance)
				get_tree().current_scene.add_child(bullet_instance)
				can_shoot = false
				bullet_instance.position = position
			#$Camera2D.position = bullet.position
				bullet_instance.position.y += 60
			#if $CollisionShape2D.rotation_degrees == 90:
				#bullet_instance.position.y += 0
			#print('plr', position)
			#print('bullet', bullet.position)
				if $AnimatedSprite2D.flip_h == false:
					bullet_instance.speed = 50
					bullet_instance.position.x += 10
				else:
					bullet_instance.speed = -50
					bullet_instance.position.x += -10
				cooldown.start(1)

	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("jump"):
		if no_gv == true:
			if is_on_floor() and $AnimatedSprite2D.flip_v != true or is_on_ceiling() and $AnimatedSprite2D.flip_v == true:
				if $AnimatedSprite2D.flip_v == false:
					$AnimatedSprite2D.flip_v = true
				else:
					$AnimatedSprite2D.flip_v = false
		else:
			if is_on_floor():
				velocity.y = JUMP_VELOCITY
				sfxJump.play()
				if heroSkin == "default":
					anim_plr.play("jump")
				else:
					anim_plr.play("jump-%s"%heroSkin)
			elif not is_on_floor() and doubleJump and not config.get_value("options",'doublejump'):
				doubleJump = false
				velocity.y = JUMP_VELOCITY
				sfxJump.play()
				anim_plr.stop()
				if heroSkin == "default":
					anim_plr.play("jump")
				else:
					anim_plr.play("jump-%s"%heroSkin)
	if position.y >= 1120:
		#currentHealth = maxHealth
		#healthChanged.emit(currentHealth)
		#sfxDeath.play()
		#await get_tree().create_timer(1.5).timeout
		#gos.visible = true
		#Engine.time_scale = 0
		if get_tree().current_scene.name == 'FirstLevel':
			if checkpoint == false:
				position.y = -155
				position.x = 275
			else:
				position.y = 215
				position.x = 14400
		elif get_tree().current_scene.name == 'SecondLvl':
			if checkpointCold == false:
				position.y = 170
				position.x = 276
			else:
				if get_parent().get_node_or_null("Boss"):
					$"../Boss".hp = 5
					$"../Boss".position.x = 11670
					$"../Boss".position.y = -85
				position.y = -475
				position.x = 11459
		elif get_tree().current_scene.name == 'ThirdLvl':
			if checkpoint == false:
				position.y = 1000
				position.x = 276
			else:
				position.y = 225
				position.x = 5090
		elif get_tree().current_scene.name == 'FourthLevel':
			if checkpoint == false:
				position.y = 667
				position.x = -4436.04
			else:
				position.y = -120
				position.x = 5620
		elif get_tree().current_scene.name == 'Cloudlvl':
			if checkpoint == false:
				position.y = 966
				position.x = 290
			else:
				position.y = 840
				position.x = 8820
		elif get_tree().current_scene.name == 'last_lvl':
			if checkpointLast == false:
				position.x = -157.036
				position.y = 153
			else:
				if get_parent().get_node_or_null("Pluton"):
					$"../Pluton".hp = 10
					$"../Pluton".position.x = 7209
					$"../Pluton".position.y = 689
				position.x = 6217
				position.y = 420
		elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
			if get_tree().current_scene.name == "Trainer" and checkpoint:
				position.y = -870
				position.x = 7815
			elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
				if get_parent().get_node_or_null("Boss"):
					$"../Boss".hp = 20
					$"../Boss".position.x = 17634
					$"../Boss".position.y = 304
				position.y = -168
				position.x = 17093
			else:
				position.y = 22
				position.x = 189
	
	for i in get_slide_collision_count():
		if get_slide_collision_count() > 0:
			var collision = get_slide_collision(i)
			
			#print(collision.get_collider())
			
			if collision.get_collider() != null:
				if collision.get_collider().is_in_group("wall_break_hammer"):
					if takenHammer == true:
						takenHammer = false
						$"../WallBreak/Hammer".visible = true
						get_node("BreakHammer").start(1)
						await get_node("BreakHammer").timeout
						var tween = get_tree().create_tween()
						tween.tween_property($"../WallBreak/Hammer", "rotation", 1, 0.5)
						tween.tween_callback($"../WallBreak".queue_free)
				#if collision.get_collider().is_in_group("enemy"):
				##hurtByEnemy(collision)
					#if get_tree().current_scene.name == 'FirstLevel':
						#position.y = -155
						#position.x = 275
					#elif get_tree().current_scene.name == 'SecondLvl':
						#position.y = 170
						#position.x = 276
					#elif get_tree().current_scene.name == 'ThirdLvl':
						#position.y = 1000
						#position.x = 276
					#elif get_tree().current_scene.name == 'FourthLevel':
						#position.y = 667
						#position.x = -4436.04
					#elif get_tree().current_scene.name == 'Cloudlvl':
						#position.y = 966
						#position.x = 290
			#elif collision.get_collider().is_in_group("interact_break"):
				#$"../Ishere/imag".texture = load('res://resources/interactive/hammer/taken.png')
				elif collision.get_collider().is_in_group('box'):
					var push_direction = -collision.get_normal()
					collision.get_collider().apply_central_impulse(push_direction * 1)	

	
	
	
	move_and_slide()


	


	

func _on_loop_sound(sound):
	sound.stream_paused = false

func _on_cooldown_timeout():
	can_shoot = true


func _on_hurt_box_area_entered(area):
	#print("Area name:", area.name)
	if area.name == "hitBox" and area.monitoring == true:
		#canDmg = false

		currentHealth -= 1
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)
	elif area.name == "Mine" and area.monitoring == true:
		#canDmg = false
		currentHealth -= 2
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			sfxDeath.play()
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#area.get_parent().queue_free()
	elif area.name == "bossHit" and area.monitoring == true:
		#canDmg = false
		currentHealth -= 2
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			sfxDeath.play()
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#area.get_parent().queue_free()
	elif area.name == 'bossEnter' and area.monitoring == true:
		checkpointCold = true
	elif area.name == "bulletEnemy" and area.monitoring == true:
		
		#canDmg = false
	
		currentHealth -= 1
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)
	elif area.name == 'killerBoom' and area.monitoring == true:
		currentHealth -= abs(int(area.get_parent().angular_velocity)/5)
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			currentHealth = maxHealth
		if abs(int(area.get_parent().angular_velocity)/5) != 0:
			healthChanged.emit(currentHealth)
			knockback(area.get_parent().position)
			effects.play("hurtbit")
			hurtCD.start()
			await hurtCD.timeout
			effects.play("RESET")
		#dmgCD.start(3)
	elif area.name == "icicle" and area.monitoring == true:
		#canDmg = false

		currentHealth -= 1
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		#knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)
	elif area.name == "DamagePlayer" and area.monitoring == true:
		#canDmg = false

		currentHealth -= 4
		if currentHealth < 1:
			#await get_tree().create_timer(1.5).timeout
			gos.visible = true
			sfxDeath.play()
			Engine.time_scale = 0
			#sfxDeath.play()
			if get_tree().current_scene.name == 'FirstLevel':
				if checkpoint == false:
					position.y = -155
					position.x = 275
				else:
					position.y = 215
					position.x = 14400
			elif get_tree().current_scene.name == 'SecondLvl':
				if checkpointCold == false:
					position.y = 170
					position.x = 276
				else:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 5
						$"../Boss".position.x = 11670
						$"../Boss".position.y = -85
					position.y = -475
					position.x = 11459
			elif get_tree().current_scene.name == 'ThirdLvl':
				if checkpoint == false:
					position.y = 1000
					position.x = 276
				else:
					position.y = 225
					position.x = 5090
			elif get_tree().current_scene.name == 'FourthLevel':
				if checkpoint == false:
					position.y = 667
					position.x = -4436.04
				else:
					position.y = -120
					position.x = 5620
			elif get_tree().current_scene.name == 'Cloudlvl':
				if checkpoint == false:
					position.y = 966
					position.x = 290
				else:
					position.y = 840
					position.x = 8820
			elif get_tree().current_scene.name == 'last_lvl':
				if checkpointLast == false:
					position.x = -157.036
					position.y = 153
				else:
					if get_parent().get_node_or_null("Pluton"):
						$"../Pluton".hp = 10
						$"../Pluton".position.x = 7209
						$"../Pluton".position.y = 689
					position.x = 6217
					position.y = 420
			elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
				if get_tree().current_scene.name == "Trainer" and checkpoint:
					position.y = -870
					position.x = 7815
				elif get_tree().current_scene.name == "graylvl" and checkpointDLC:
					if get_parent().get_node_or_null("Boss"):
						$"../Boss".hp = 20
						$"../Boss".position.x = 17634
						$"../Boss".position.y = 304
					position.y = -168
					position.x = 17093
				else:
					position.y = 22
					position.x = 189
			currentHealth = maxHealth
		healthChanged.emit(currentHealth)
		#knockback(area.get_parent().position)
		effects.play("hurtbit")
		hurtCD.start()
		await hurtCD.timeout
		effects.play("RESET")
		#dmgCD.start(3)

#func _on_damage_time_timeout():
	#canDmg = true
#DamagePlayer
func knockback(enemyVelocity: Vector2):
	var knockbackDirection = (enemyVelocity - velocity).normalized() * knockbackPower
	velocity = knockbackDirection
	move_and_slide()


func die():
	killed.emit()
	queue_free()

func damagePlayer(damage,area):
	currentHealth -= 1
	if currentHealth < 1:
		#await get_tree().create_timer(1.5).timeout
		gos.visible = true
		sfxDeath.play()
		Engine.time_scale = 0
			#sfxDeath.play()
		if get_tree().current_scene.name == 'FirstLevel':
			position.y = -155
			position.x = 275
		elif get_tree().current_scene.name == 'SecondLvl':
			if checkpointCold == false:
				position.y = 170
				position.x = 276
			else:
				if get_parent().get_node_or_null("Boss"):
					$"../Boss".hp = 5
					$"../Boss".position.x = 11670
					$"../Boss".position.y = -85
				position.y = -475
				position.x = 11459
		elif get_tree().current_scene.name == 'ThirdLvl':
			if checkpoint == false:
				position.y = 1000
				position.x = 276
			else:
				position.y = 225
				position.x = 5090
		elif get_tree().current_scene.name == 'FourthLevel':
			position.y = 667
			position.x = -4436.04
		elif get_tree().current_scene.name == 'Cloudlvl':
			if checkpoint == false:
				position.y = 966
				position.x = 290
			else:
				position.y = 840
				position.x = 8820
		elif get_tree().current_scene.name == 'last_lvl':
			if checkpointLast == false:
				position.x = -157.036
				position.y = 153
			else:
				if get_parent().get_node_or_null("Pluton"):
					$"../Pluton".hp = 10
					$"../Pluton".position.x = 7209
					$"../Pluton".position.y = 689
				position.x = 6217
				position.y = 420
		currentHealth = maxHealth
	healthChanged.emit(currentHealth)
	knockback(area.get_parent().position)
	effects.play("hurtbit")
	hurtCD.start()
	await hurtCD.timeout
	effects.play("RESET")
#func _on_character_killed():
	#await get_tree().create_timer(1.5).timeout
	#gos.visible = true
#func _on_break_hammer_timeout(collision):
	
