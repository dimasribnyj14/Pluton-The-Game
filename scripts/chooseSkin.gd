extends BoxContainer
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_rect_pressed():
	config.set_value('saves', 'skin', $TextureRect/Label2.text.to_lower())
	$"../../Skin".texture = load("res://resources/player/hero/%s/Idle/1.png"%$TextureRect/Label2.text.to_lower())
	config.save('user://config.cfg')
	
