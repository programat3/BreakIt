class_name Level
extends Node2D

export(int) var id

func _process(delta):
	if Input.is_action_just_pressed("trigger"):
		$SpecialTilesHolder/Grifo.activate()
	

func _ready():
	$HUD/Button.connect("pressed", self,"_on_reset_button_pressed")
	
func _on_reset_button_pressed():
	var connection_string = "res://levels/Level%s.tscn" % self.id 
	get_tree().change_scene(connection_string)



func _on_Bandedra_broken(_source_pos, _target_poss):
	if id < 4:
		self.id +=1
		var connection_string = "res://levels/Level%s.tscn" % self.id 
		get_tree().change_scene(connection_string)
	else:
		get_tree().change_scene("res://starting_scene/Control.tscn")

