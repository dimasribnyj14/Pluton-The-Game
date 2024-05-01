extends Area2D
@onready var timer = $"../Remove"
@onready var minepressed = $"../AnimationPlayer"
var pressed = false
@onready var player = $"../../CharacterBody2D"
#func _on_hit_box_area_entered(area):
var config = ConfigFile.new()
var configFile = config.load('user://config.cfg')
func _ready():
	minepressed.play("new_animation")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area):
	if area.name == "hurtBox" and pressed == false or area.name == 'bullet' and pressed == false and not config.get_value("options",'doublejump'):
		if area.name == 'bullet' and not config.get_value("options",'doublejump'):
			if player.global_position.distance_to(global_position) < 300:
				if player.global_position.distance_to(global_position) < 100:
					player.damagePlayer(2, get_node("."))
				else:
					player.damagePlayer(1, get_node("."))
		$"../AudioStreamPlayer2D".play()
		set_collision_layer_value(1, false)
		set_collision_mask_value(1, false)
		pressed = true
		minepressed.play("boom")
		$"../MinePressed".position.x = 21
		$"../MinePressed".position.y = 10
		monitoring = false
		monitorable = false
		$CollisionShape2D.set_disabled(true)
