class_name Tile
extends Node2D


signal broken(target_poss)

var tilemap
var activated := false
export(Array, Vector2) var target_tiles_positions


func activate():
	if not self.activated:
		self.activated = true
		emit_signal("broken", self.target_tiles_positions)
		for target_pos in self.target_tiles_positions:
			tilemap.get_cell(self.position + target_pos).activate()
		#for target_tile in self.target_tiles_positions:
		#	target_tile.activate()

