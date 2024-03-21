extends Control

@onready var coins_counter = $coinsCounter
@onready var life = $life

# Called when the node enters the scene tree for the first time.
func _ready():
	coins_counter.text = str(Globals.coins)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	coins_counter.text = str(Globals.coins)
	
	if Globals.life == 3:
		life.set_frame(3)
	elif Globals.life == 2:
		life.set_frame(2)
	elif Globals.life == 1:
		life.set_frame(1)
	elif Globals.life == 0:
		life.set_frame(0)
	


func _on_area_2d_body_entered(body):
	if body.name == 'player':
		get_tree().change_scene_to_file("res://levels/game_over.tscn")
