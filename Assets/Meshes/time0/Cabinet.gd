extends "res://Scripts/info_object.gd"
class_name Cabinet

var open: bool = false
var anim_player: AnimationPlayer

func _ready():
	anim_player = get_parent().get_parent().get_node("AnimationPlayer")
	anim_player.play("Closed")

func player_activate(player):
	if open:
		anim_player.play_backwards("Open") # close
	else:
		anim_player.play("Open") # open
	open = !open
