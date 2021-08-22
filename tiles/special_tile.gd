class_name SpecialTile 
extends Tile


signal infected

var click_var = false
var infected_value = true
var current_effect
var target_tiles_positions_original_length
enum {FIREHYDRANT_HEALTHY,SEWER_HEALTHY, SIGNPOST_HEALTHY, FLAG_DOWN, FIREHYDRANT_BROKEN, SEWER_BROKEN, SIGNPOST_BROKEN, FLAG_UP}
export(
	int,
	"FIREHYDRANT_HEALTHY",
	"SEWER_HEALTHY",
	"SIGNPOST_HEALTHY",
	"FLAG_DOWN",
	"FIREHYDRANT_BROKEN",
	"SEWER_BROKEN",
	"SIGNPOST_BROKEN",
	"FLAG_UP"
) var current_frame

export(
	int,
	"FIREHYDRANT_HEALTHY",
	"SEWER_HEALTHY",
	"SIGNPOST_HEALTHY",
	"FLAG_DOWN",
	"FIREHYDRANT_BROKEN",
	"SEWER_BROKEN",
	"SIGNPOST_BROKEN",
	"FLAG_UP"
) var activated_frame

export(Resource) var effect

func _input(event):
	if event.is_action_pressed("click"):
		click_var = true

func _ready():
	$Sprite.frame = current_frame
	self.target_tiles_positions_original_length = len(target_tiles_positions)
	self._set_tile_pointers()

func _set_tile_pointers():
	for pos in self.target_tiles_positions:
		var tile_pointer = load("res://tiles/TilePointer.tscn").instance()
		tile_pointer.position = pos * TILE_SIZE
		$Pointer.add_child(tile_pointer)

func set_current_frame(frame: int):
	current_frame = frame
	$Sprite.frame = current_frame

func _animate_activation():
	self.set_current_frame(self.activated_frame)


func infect():
	self.effect.infect(self)


func disinfect():
	self.effect.disinfect(self)


func get_target_tiles_positions():
	return self.target_tiles_positions


func add_target_tiles_positions(new_positions):
	for pos in new_positions:
		var tile_pointer = load("res://tiles/TilePointer.tscn").instance()
		tile_pointer.position = pos * TILE_SIZE
		$Pointer.add_child(tile_pointer)
	self.target_tiles_positions += new_positions


func reset_target_tiles_positions():
	var infected_ttp_length = len(target_tiles_positions)
	var pointers = $Pointer.get_children()
	for i in range(infected_ttp_length - target_tiles_positions_original_length):
		var remove_pos = infected_ttp_length - 1 - i
		self.target_tiles_positions.remove(remove_pos)
		pointers[remove_pos].queue_free()

func _on_Area2D_mouse_entered(): 
	$Pointer.visible = true


func _on_Area2D_mouse_exited():
	$Pointer.visible = false


func _on_Area2D_body_entered(body):
	if click_var && infected_value:
#		emit_signal("infected", infected_value, 2)
		infected_value = false
		self.infect()
	elif click_var:
#		emit_signal("infected", infected_value, 1)
		infected_value = true
		self.disinfect()
