extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str($"../../../".code)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $"../1".visible and $"../2".visible and $"../3".visible and $"../4".visible and $"../5".visible and $"../6".visible:
		visible = true
