class_name AmplifierEffect
extends Effect


export(int) var amplitude


func infect(tile):
	var new_target_positions = []
	for pos in tile.get_target_tiles_positions():
		for i in range(2, self.amplitude + 1):
			new_target_positions.append(pos * i)
	tile.add_target_tiles_positions(new_target_positions)


func disinfect(tile):
	tile.reset_target_tiles_positions()

