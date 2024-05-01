extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y >= 2000:
		queue_free()


func _on_area_2d_body_entered(body):
	#pass
	if body.name == 'CharacterBody2D':
		queue_free()
	#if not body.name == 'flyWind' and not body.name == 'BALL-boom':
		#queue_free()


func _on_timer_timeout():
	queue_free()
