extends Area2D
@export var speed: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed


func _on_body_entered(body):
	#if body.name.contains('RigidBody2D'):
		#body.queue_free()
		#body.find_node('')
		#queue_free()
	if body.name == 'CharacterBody2D':
		pass
	else:
		queue_free()
