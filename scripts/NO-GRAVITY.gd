extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		body.no_gv = true


func _on_body_exited(body):
	if body.name == 'CharacterBody2D':
		if body.get_node('AnimatedSprite2D').flip_v == true:
			body.get_node('AnimatedSprite2D').flip_v = false
		body.no_gv = false
