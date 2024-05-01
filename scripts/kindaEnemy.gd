extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("norm")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_kindaenemy_area_entered(area):
	if area.name == 'bullet':
		area.queue_free()
		$AnimationPlayer.play("dead")
		$KINDAENEMY.set_collision_layer_value(1,false)
		$KINDAENEMY.set_collision_mask_value(1,false)
		$InvisibleWall.set_collision_layer_value(1,false)
		$InvisibleWall.set_collision_mask_value(1,false)
