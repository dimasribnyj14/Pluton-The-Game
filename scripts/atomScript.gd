extends TextureRect
@export var path: String

# Called when the node enters the scene tree for the first time.
func _ready():
	if not OS.get_name() == "Windows" or not OS.get_name() == "OSX":
		texture = load(path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
