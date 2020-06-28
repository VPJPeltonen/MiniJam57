extends "res://Scripts/info_object.gd"
class_name Cabinet

var opened: bool = false
var anim_player: AnimationPlayer

func _ready():
	anim_player = get_parent().get_parent().get_node("AnimationPlayer")
	anim_player.play("Closed")

func player_activate(player):
	opened = !opened
	if opened:
		anim_player.play("Open")
	else:
		anim_player.play_backwards("Open")
