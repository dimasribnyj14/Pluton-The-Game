extends Button
@onready var label = $"../Label"
@onready var code = $"../../../../CharacterBody2D".code
@onready var sound = $"../click"
@onready var error = $"../error"
@onready var confirm = $"../confirm"

func _ready():
	print(code)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	
	if name != "ok":
		if label.text.length() < 6:
			sound.play()
			label.text += name
	else:
		if int(label.text) == int(code):
			confirm.play()
			$"../../../../StaticBody2DDoor".set_collision_layer_value(1,false)
			$"../../../../StaticBody2DDoor".set_collision_mask_value(1,false)
			$"../../../../StaticBody2DDoor/Area2D2".set_collision_layer_value(1,false)
			$"../../../../StaticBody2DDoor/Area2D2".set_collision_mask_value(1,false)
			$"../../../../StaticBody2DDoor/Area2D2/Sprite2D".visible = false
			$"../../../../StaticBody2DDoor/Door".self_modulate = Color.from_hsv(1,1,1,0.5)
		else:
			error.play()
		$"../../TextureRect".visible = false
		label.text = ''
