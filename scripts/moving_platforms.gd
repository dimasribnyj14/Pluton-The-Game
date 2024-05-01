extends Node2D
var rdm = RandomNumberGenerator.new()
@export var imageName = 'fire'
@export var time = 0
@onready var timer = $Timer
func _ready():
	$Platform/Sprite2D.texture = load("res://resources/interactive/fixedMoveplatform/%s.png" % imageName)	
	timer.start(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	
	
	$Platform/AnimationPlayer.play("move_loop")
