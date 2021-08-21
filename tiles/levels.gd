class_name Level
extends Node2D


func _process(delta):
	if Input.is_action_pressed("trigger"):
		$SpecialTilesHolder/Grifo.activate()
