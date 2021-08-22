class_name Tile
extends Node2D

const TILE_SIZE = 64

signal broken(source_pos, target_poss)

var tilemap
var activated := false
export(Array, Vector2) var target_tiles_positions

func activate():
	if not self.activated:
		self.activated = true
		self._animate_activation()
#		emit_signal("broken", self.position / TILE_SIZE, self.target_tiles_positions)


func _animate_activation():
	pass

