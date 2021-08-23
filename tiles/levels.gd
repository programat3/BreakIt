class_name Level
extends Node2D

export(int) var id
export(int) var available_spores
var current_score



func _process(delta):
	if Input.is_action_just_pressed("trigger"):
		$SpecialTilesHolder/Grifo.activate()
	

func _ready():
	for tile in $SpecialTilesHolder.get_children():
		tile.connect("infected", self, "_on_SpecialTile_infected") 
	$HUD/Button.connect("pressed", self,"_on_reset_button_pressed")
	self.current_score = self.available_spores
	$Mandrita.set_current_spores(self.available_spores)
	self._update_score()

func _on_reset_button_pressed():
	var connection_string = "res://levels/Level%s.tscn" % self.id 
	get_tree().change_scene(connection_string)


func _update_score():
	$SporeCounter/Label.text = str(self.current_score)


func _on_Bandedra_broken(_source_pos, _target_poss):
	if id < 4:
		self.id +=1
		var connection_string = "res://levels/Level%s.tscn" % self.id 
		get_tree().change_scene(connection_string)
	else:
		get_tree().change_scene("res://starting_scene/Control.tscn")


func _on_SpecialTile_infected(is_not_infected):
	var delta # = -1 + 2 * int(is_not_infected)
	if is_not_infected:
		delta = 1
	else:
		delta = -1
	$Mandrita.set_current_spores($Mandrita.get_current_spores() + delta)
	self.current_score += delta
	self._update_score()

