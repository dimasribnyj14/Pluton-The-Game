extends RigidBody2D #Наследуем RigidBody2D
#Експортируем свойства
var start_x #Свойства start_x (начало пути)
var player = null
var can_jump = true
#@export var start_y: int = 0 #Свойства start_y (НЕИСПОЛЬЗОВАТЬ)
#@export var end_x: int = 0 #Свойства end_x (конец пути)
var SPEED: float = 3 #Свойства SPEED (скорость бота
#Направление
var gravity = ProjectSettings.get_setting('physics/2d/default_gravity')
var direction: int = 0
#var on_ground := 0
@onready var timer = $Timer
# Функция, которая запускается при запуске сцены
func _ready():
	pass	
	#start_x = position.x #Ставим начальный путь
	#if start_y != 0: #Если start_y не равняется нулю, то
		#position.y = start_y #


# Функция для процесса работы бота
func _physics_process(delta):
	
	#Смены направления
	# Если позиция x больше или равна конца пути, то
	if player:
		if position.x >= player.position.x:
			direction = -1 #Меняем направление назад
			$CollisionShape2D.position.x = 15
			$AnimatedSprite2D.flip_h = true #Отзеркаливаем горизонтально
		else: #Если позиция x меньше конца пути, то
			direction = 1 #Меняем направление назад
			$CollisionShape2D.position.x = 35
			$AnimatedSprite2D.flip_h = false #Отзеркаливаем горизонтально обратно
	# Если бот дошел до конца, то возращается обратно
	#if position.x <= $"../CharacterBody2D".position + 10 and position.x >= $"../CharacterBody2D".position - 10:
		#var temp = start_x # Меняем темп на начало пути
		#start_x = end_x # Начало пути стало концом пути
	#print(self.velocity.x)
		#end_x = temp # Конец пути стало равняться началом пути
	print($RayCast2D.is_colliding())
	if $RayCast2D.is_colliding() and can_jump and linear_velocity.length() < 5 : #linear_velocity.length() < 1 
		
		can_jump = false
		set_axis_velocity(Vector2(0, -5))
		
		timer.start(5)
		
		#SPEED = 1.0
	# Если передвигается
	if direction:
		linear_velocity.x = direction * SPEED #Двигаем бота
		
	#print(linear_velocity.length())
	# Без этого, бот был бы пьян.
	move_and_collide(linear_velocity)

	if position.y >= 2000:
		queue_free()



#func _on_body_exited(body):
	#on_ground -= 1


func _on_timer_timeout():

	can_jump = true




func _on_find_plr_body_entered(body):
	if body.name == 'CharacterBody2D':
		player = body


func _on_find_plr_body_exited(body):
	if body.name == 'CharacterBody2D':
		player = null
