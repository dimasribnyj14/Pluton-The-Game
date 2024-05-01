extends TouchScreenButton

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_tree().current_scene.name != "graylvl":
		visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
