extends Node2D

func update_inventory(items):
	var inventory = "Inventory:\n"
	for item in items:
		inventory += item + "\n"
	$InfoBox2/ColorRect/Label.text = inventory
