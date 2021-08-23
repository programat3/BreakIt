class_name SpecialTile 
extends Tile


signal infected(is_not_infected)

const ACTIVATION_WAIT_TIME = 1

var activation_timer = Timer.new()
var click_var = false
var is_not_infected = true
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
	self.activation_timer.connect("timeout", self, "_on_activation_timer_timeout")
	self.add_child(self.activation_timer)
	$Sprite.frame = current_frame
	self.target_tiles_positions_original_length = len(target_tiles_positions)
	self._set_tile_pointers()


func _on_activation_timer_timeout():
	self.activation_timer.stop()
	emit_signal("broken", self.position / TILE_SIZE, self.target_tiles_positions)


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
	self.activation_timer.start(ACTIVATION_WAIT_TIME)
	for pointer in $Pointer.get_children():
		pointer.get_node("AnimationPlayer").play("destruction")


func _animate_infection():
	var spore = load("res://esporas/spore_1.tscn").instance()
#	spore.position = self.position
	spore.get_child(0).emitting = true
	self.add_child(spore)

func _animate_disinfection():
	pass

func infect():
	self.is_not_infected = false
	self._animate_infection()
	self.effect.infect(self)
	emit_signal("infected", self.is_not_infected)


func disinfect():
	self.is_not_infected = true
	self.effect.disinfect(self)
	emit_signal("infected", self.is_not_infected)


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
	for pointer in $Pointer.get_children():
		pointer.get_node("Reference").visible = true


func _on_Area2D_mouse_exited():
	for pointer in $Pointer.get_children():
		pointer.get_node("Reference").visible = false


func _on_Area2D_body_entered(body):
	
	if click_var:
		if self.is_not_infected and body.get_current_spores() > 0:
			body.set_current_spores(body.get_current_spores() - 1)
			self.infect()
		else:
			if !self.is_not_infected:
				body.set_current_spores(body.get_current_spores() + 1)
				self.disinfect()

