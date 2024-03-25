extends TextureButton
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
@export var item_to_buy = 'jungle'
@onready var valueCrystals = $"../../../../Value/Label"
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#
#func _on_button_down():
	#$Label2.modulate = Color(0.3,0.3,0.3)
#
#
#func _on_button_up():
	#$Label2.modulate = Color(1,1,1)


func _on_pressed():
	if config.get_value("saves","crystal") >= int($Label2.text):
		config.set_value("saves","crystal",config.get_value("saves","crystal")-int($Label2.text))
		config.set_value("skins",item_to_buy,true)
		valueCrystals.text = str(config.get_value("saves","crystal")-int($Label2.text))
		visible = false
		get_parent().get_node(item_to_buy).visible = true
		config.save('user://config.cfg')
