extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	Engine.time_scale = 1
	$"../../../".hide()
	$"../../../../TouchScreenButton2".show()
	$"../../../../TouchScreenButton5".show()
	$"../../../../TouchScreenButton6".show()
	$"../../../../TouchScreenButton4".show()
	$"../../../../TouchScreenButton3".show()
	$"../../../../TouchScreenButton".show()
