class_name Level
extends Node2D

func _ready():
	add_child(load("res://tiles/Grifo.tscn").instance())
