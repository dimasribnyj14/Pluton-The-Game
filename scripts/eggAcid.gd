extends Area2D
@onready var timer = $Timer
@onready var acid = preload("res://scenes_for_scenes/enemy/poop.tscn")
@export var end_x = 0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body.name == 'CharacterBody2D':
		var acid_instance = acid.instantiate()
		get_tree().current_scene.add_child(acid_instance)
		acid_instance.end_x = end_x
		acid_instance.start_x = position.x
		acid_instance.position = position
		acid_instance.position.y += 200
		acid_instance.position.x += 175
		
		set_collision_mask_value(1,false)
		set_collision_layer_value(1,false)
		
		timer.start(0.1)
		


func _on_timer_timeout():
	queue_free()
