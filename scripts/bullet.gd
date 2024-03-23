extends Area2D
@export var speed: float
@export var enemyBullet = false
@onready var timer = $EnemyDed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed
func _on_enemy_ded_timeout(body):
	body.queue_free()

func _on_body_entered(body):
	if body.name.contains('RigidBody2D'):
		if body.get_node_or_null("hitBox"):
			if body.get_node("hitBox").get_node_or_null("CollisionShape2D"):
				queue_free()
				body.remove_from_group("enemy")
				body.get_node('CollisionShape2D').disabled = true
				body.get_node('hitBox').get_node("CollisionShape2D").disabled = true
				body.get_node('hitBox').monitoring = false
				body.get_node('hitBox').monitorable = false
				body.get_node('hitBox').set_collision_layer_value(1, false)
				body.get_node('hitBox').set_collision_mask_value(1, false)
				body.dead = true
				body.modulate = Color('00ffff')
				body.get_node('PointLight2D').energy = 1
				var tween = get_tree().create_tween()
				tween.tween_property(body, "modulate", Color(0,1,1,0), 1)
				tween.tween_property(body.get_node('PointLight2D'), "energy", 0, 0.5)
				tween.tween_callback(body.queue_free)
				#timer.connect('timeout',_on_enemy_ded_timeout(body))
				timer.start(3)
			#if body.modulate.a == 0:
				#body.queue_free()
	elif body.name == 'Boss' and body.cant_search_player == false:
		queue_free()
		if body.hp > 0:
			
			
			body.hp -= 1
			body.modulate = Color('00ffff')
			var tween = get_tree().create_tween()
			tween.tween_property(body, "modulate", Color(1,1,1,1), 1)
		else:
			body.remove_from_group("enemy")
			body.get_node('CollisionShape2D').disabled = true
			body.get_node('bossHit').get_node("CollisionShape2D").disabled = true
			body.get_node('bossHit').monitoring = false
			body.get_node('bossHit').monitorable = false
			body.get_node('bossHit').set_collision_layer_value(1, false)
			body.get_node('bossHit').set_collision_mask_value(1, false)
			body.dead = true
			body.modulate = Color('00ffff')
			body.get_node('PointLight2D').energy = 1
			var tween = get_tree().create_tween()
			tween.tween_property(body, "modulate", Color(0,1,1,0), 1)
			tween.tween_property(body.get_node('PointLight2D'), "energy", 0, 0.5)
			tween.tween_callback(body.queue_free)
			#timer.connect('timeout',_on_enemy_ded_timeout(body))
			timer.start(3)
	elif body.name == 'Pluton' and body.cant_search_player == false:
		queue_free()
		if body.hp > 0:
			
			
			body.hp -= 1
			body.modulate = Color('00ffff')
			var tween = get_tree().create_tween()
			tween.tween_property(body, "modulate", Color(1,1,1,1), 1)
		else:
			body.remove_from_group("enemy")
			body.get_node('CollisionShape2D').disabled = true
			body.get_node('bossHit').get_node("CollisionShape2D").disabled = true
			body.get_node('bossHit').monitoring = false
			body.get_node('bossHit').monitorable = false
			body.get_node('bossHit').set_collision_layer_value(1, false)
			body.get_node('bossHit').set_collision_mask_value(1, false)
			body.dead = true
			body.modulate = Color('00ffff')
			body.get_node('PointLight2D').energy = 10
			var tween = get_tree().create_tween()
			tween.tween_property(body, "modulate", Color(0,1,1,0), 5)
			tween.tween_property(body.get_node('PointLight2D'), "energy", 0, 1)
			tween.tween_callback(body.queue_free)
			#timer.connect('timeout',_on_enemy_ded_timeout(body))
			timer.start(1)
	elif body.name == 'CharacterBody2D':
		pass
	else:
		queue_free()



