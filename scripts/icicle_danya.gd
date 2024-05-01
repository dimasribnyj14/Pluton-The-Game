extends Node

# Ссылка на игрока
var player = null
# Максимальное расстояние, при котором сосулька начнет падать
var maxDistance = 50
# Ссылка на сосульку
var icicle = null

func _ready():
	# Найти игрока и сосульку по их именам
	player = get_node("Player")
	icicle = get_node("Icicle")

func _process(delta):
	# Получить позиции игрока и сосульки
	var player_pos = player.global_position
	var icicle_pos = icicle.global_position
	# Вычислить расстояние между ними
	var distance = player_pos.distance_to(icicle_pos)
	# Если расстояние меньше максимального
	if distance < maxDistance:
		# Удалить сосульку из группы "icicle", чтобы она перестала взаимодействовать с игроком
		icicle.remove_from_group("icicle")
		# Запустить анимацию падения сосульки (предполагается, что у вас есть анимация падения)
		icicle.play("fall_animation")
		# Отключить коллайдер сосульки, чтобы игрок мог проходить сквозь нее
		icicle.set_collision_layer_bit(0, false)
