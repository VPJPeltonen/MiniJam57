extends Node2D


func show_info(item):
	if item != null:
		show()
		$InfoBox/ColorRect/Label.text = item.info
