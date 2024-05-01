extends Button
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
var list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	for key in config.get_section_keys('levels'):
		list.append(config.get_value('levels',key))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	if false in list:
		$"../Sure".visible = true
		$"../Button6".visible = false
		$"../VBoxContainer".visible = false
	else:
		get_tree().change_scene_to_file("res://main_scenes/dlcsChoice.tscn")
