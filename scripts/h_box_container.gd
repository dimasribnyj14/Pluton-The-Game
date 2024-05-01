extends VBoxContainer
#@export var place = ""
#@export var date = ""
var time = Time.get_datetime_dict_from_system()

# we can use format strings to pad it to a length of 2 with zeros, e.g. 01:20:12

# Called when the node enters the scene tree for the first time.
func _ready():
	#
	if get_tree().current_scene.name == 'Ship' or get_tree().current_scene.name == 'Trainer':
		$Date.text = "%02d.%02d.%02d" % [time.day, time.month, time.year] + " - BIOTIME"
	#$Place.text = place
	#$Date.text = date
	#if get_tree
	$Timer.start(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Place.visible = false
	$Date.visible = false
