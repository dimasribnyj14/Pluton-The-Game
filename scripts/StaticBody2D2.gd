extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().get_parent().get_node_or_null("Boss") == null:
		set_collision_layer_value(1,false)
		set_collision_mask_value(1,false)
