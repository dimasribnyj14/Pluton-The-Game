extends RigidBody2D
@onready var key = preload("res://scenes_for_scenes/key.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#move_and_collide(linear_velocity)



#func _on_area_2d_body_entered(body):
	#
	#if body.name.contains("TileMap"):
		#
		#if angular_velocity < -1:
			#print("removed")
			#queue_free()


func _on_area_2d_area_entered(area):
	if area.name == 'BreakBox':
		var key_instance = key.instantiate()
		get_tree().current_scene.add_child(key_instance)
		key_instance.position = position
		queue_free()
