extends Node2D



func show_info(item):
	if item != null:
		show()
		$InfoBox/ColorRect/Label.text = item.info
		$InfoBox.rect_position = get_parent().get_node("Head/Camera").unproject_position(item.translation)
