extends Area2D
var rng = RandomNumberGenerator.new()
@export var falling = false
@onready var timer = $Timer
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y >= 2000:
		queue_free()
	if falling:
		position.y += 10


func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		
		if int(rng.randf_range(0.0, 10.0)) > 5:
			falling = true
			$icicle.set_collision_layer_value(1,true)
			$icicle.set_collision_mask_value(1,true)
			


func _on_hit_box_body_entered(body):
	if body.name.contains('TileMap') or body.name == 'CharacterBody2D':
		queue_free()
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

func _on_timer_timeout(body):
	body.queue_free()
