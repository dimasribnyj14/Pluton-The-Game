extends Area2D

@onready var minepressed = $MinePressed


func _on_hit_box_area_entered(area):
	if area.name == "hurtBox":
		minepressed.play = "MinePressed"

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
