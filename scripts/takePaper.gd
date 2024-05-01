extends Area2D
@export var id = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = load("res://resources/papers/%s.png"%id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == "CharacterBody2D":
		queue_free()
		body.get_node("CanvasLayer").get_node("Control").get_node(str(id)).visible = true
