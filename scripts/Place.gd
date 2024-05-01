extends Label
@onready var sound = $"../Type"
var fulltext
var currenttext = ''
var currentindex = 0
var typingspeed = 0.3

func _ready():
	

	#set_process(true)
	get_tree().create_timer(typingspeed).timeout.connect(self._on_timeout)

func _process(_delta):
	pass
		

func _on_timeout():
	fulltext = text
	while currentindex < len(fulltext):
		
		currenttext += fulltext[currentindex]
		self.set_text(currenttext)
		currentindex += 1
		sound.play()
		visible = true
		await get_tree().create_timer(typingspeed).timeout
