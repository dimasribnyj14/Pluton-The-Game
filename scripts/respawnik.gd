extends Button
@onready var player = $"../../../../../"
#@onready var boss = $"../../../../../../Boss"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	var boss = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("Boss")
	var pluton = get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node_or_null("Pluton")
	Engine.time_scale = 1
	$"../../../".hide()
	$"../../../../TouchScreenButton2".show()
	$"../../../../TouchScreenButton5".show()
	$"../../../../TouchScreenButton6".show()
	$"../../../../TouchScreenButton4".show()
	$"../../../../TouchScreenButton3".show()
	$"../../../../TouchScreenButton".show()
	if get_tree().current_scene.name == 'FirstLevel':
		if player.checkpoint == false:
			player.position.y = -155
			player.position.x = 275
		else:
			player.position.y = 215
			player.position.x = 14400
	elif get_tree().current_scene.name == 'SecondLvl':
		if player.checkpointCold == false:
			player.position.y = 170
			player.position.x = 276
		else:
			if boss:
				$"../../../../../../Boss".hp = 5
				$"../../../../../../Boss".position.x = 11670
				$"../../../../../../Boss".position.y = -85
			player.position.y = -475
			player.position.x = 11459
	elif get_tree().current_scene.name == 'ThirdLvl':
		if player.checkpoint == false:
			player.position.y = 1000
			player.position.x = 276
		else:
			player.position.y = 225
			player.position.x = 5090
	elif get_tree().current_scene.name == 'FourthLevel':
		if player.checkpoint == false:
			player.position.y = 667
			player.position.x = -4436.04
		else:
			player.position.y = -120
			player.position.x = 5620
	elif get_tree().current_scene.name == 'Cloudlvl':
		if player.checkpoint == false:
			player.position.y = 966
			player.position.x = 290
		else:
			player.position.y = 840
			player.position.x = 8820
	elif get_tree().current_scene.name == 'last_lvl':
		if player.checkpointLast == false:
			player.position.x = -157.036
			player.position.y = 153
		else:
			if pluton:
				$"../../../../../../Pluton".hp = 10
				$"../../../../../../Pluton".position.x = 7209
				$"../../../../../../Pluton".position.y = 689
			player.position.x = 6217
			player.position.y = 420
	elif get_tree().current_scene.name == 'graylvl' or get_tree().current_scene.name == "Trainer":
		if get_tree().current_scene.name == "Trainer" and player.checkpoint:
			player.position.y = -870
			player.position.x = 7815
		elif get_tree().current_scene.name == "graylvl" and player.checkpointDLC:
			if boss:
				$"../../../../../../Boss".hp = 20
				$"../../../../../../Boss".position.x = 17634
				$"../../../../../../Boss".position.y = 304
			player.position.y = -168
			player.position.x = 17093
		else:
			player.position.y = 22
			player.position.x = 189
