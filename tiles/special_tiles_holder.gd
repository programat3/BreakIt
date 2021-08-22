class_name SpecialTilesHolder
extends Node2D


var tiles_dict = {}


func _ready():
#	for pos in $Grifo.target_tiles_positions:
#		var tile_pointer = load("res://tiles/TilePointer.tscn").instance()
#		tile_pointer.position = self.position + pos*Tile.TILE_SIZE
#		$Grifo/Pointer.add_child(tile_pointer)
		
	for child in self.get_children():
		self.register_tile(child)
		child.connect("broken", self, "_on_SpecialTile_broken")


func _on_SpecialTile_broken(source_pos, target_tiles_positions):
	for pos in target_tiles_positions:
		var absolute_target_pos = source_pos + pos
		if absolute_target_pos in self.tiles_dict.keys():
			self.tiles_dict[absolute_target_pos].activate()


func register_tile(tile):
	self.tiles_dict[tile.position / Tile.TILE_SIZE] = tile


func get_tile(tile_pos):
	return self.tiles_dict[tile_pos]




func _on_Grifo_infected(infected_value, value):
	if infected_value:
		var spore = load("res://esporas/spore_1.tscn").instance()
		spore.position = self.position
		spore.get_child(0).emitting = true
		$Grifo.add_child(spore)
	print(infected_value)
