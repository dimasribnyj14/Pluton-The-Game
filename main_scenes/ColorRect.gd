extends ColorRect

var melting := false
var timer := 0.0 

@export var x_resolution := 100.0 
@export var max_offset := 2.0
@export var melt_speed := 0.02


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if melting:
		timer += melt_speed
		self.material.set_shader_parameter("timer", timer)
	elif Input.is_action_just_pressed("Dev_Log"):
		generate_offsets()

# Call this before transitioning, creates a copy of the screen texture so changes
# can be made underneath before melting to show the new screen.
func generate_offsets():
	var offsets = []
	for i in x_resolution:
		offsets.append(randf_range(1.0, max_offset))
	self.material.set_shader_parameter("y_offsets", offsets)
	
	var img = get_viewport().get_texture().get_image()
	var tex = ImageTexture.create_from_image(img)
	self.material.set_shader_parameter("melt_tex", tex)
	
	show()

# Call this after generate_offsets
func transition():
	self.material.set_shader_parameter("melting", true)
	melting = true
