extends Area2D
@onready var plr = $"../CharacterBody2D"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("default")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if plr.checkpoint == false:
		if area.name == "bullet":
			plr.checkpoint = true
			$PointLight2D.visible = true
			$AnimationPlayer.play("checkpoint")
