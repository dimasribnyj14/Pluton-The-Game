extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "modulate", Color(1,1,1,0), 0.3)


func _on_body_exited(body):
	if body.name == 'CharacterBody2D':
		var tween = get_tree().create_tween()
		tween.tween_property(get_parent(), "modulate", Color(1,1,1,1), 0.3)
