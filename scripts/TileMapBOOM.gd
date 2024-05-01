extends TileMap
@onready var anim = $"../Explosion"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if $"../BomBom2/Timer".playing:
		#while $"../BomBom2/Timer".pitch_scale < 4:
			#$"../BomBom2/Timer".pitch_scale += 0.001
			#print('ghopt[pj]')
			#await get_tree().create_timer(1).timeout
		#if $"../BomBom2/Timer".pitch_scale >= 4:



func _on_bombomput_body_entered(body):
	if body.name == 'CharacterBody2D':
		if body.takenBoom == true:
			$BOMBOMPUT.set_collision_layer_value(1,false)
			$BOMBOMPUT.set_collision_mask_value(1,false)
			
			$"../BomBom2/Timer".play()
			
			body.takenBoom = false
			$"../BomBom2".visible = true
			


func _on_timer_finished():
	$"../BomBom2/Timer".stop()
	$"../BomBom2/Boom".play()
	anim.play("BOOM")
	visible = false
	tile_set.remove_physics_layer(0)
	$"../BomBom2".visible = false
	$DamagePlayer.set_collision_layer_value(1,true)
	$DamagePlayer.set_collision_mask_value(1,true)
	$Timer.start(0.1)
func _on_timer_timeout():
	$DamagePlayer.set_collision_layer_value(1,false)
	$DamagePlayer.set_collision_mask_value(1,false)
	
