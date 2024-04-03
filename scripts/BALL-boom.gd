extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_angular_velocity())
	if position.y >= 2000:
		queue_free()


func _on_area_2d_body_entered(body):
	pass
	#if body.name == 'CharacterBody2D':
		#queue_free()
	#if not body.name == 'flyWind' and not body.name == 'BALL-boom':
		#queue_free()
