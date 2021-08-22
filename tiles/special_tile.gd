class_name SpecialTile 
extends Tile

var click_var = false
signal infected
var infected_value = true
#var activated
var current_effect
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

func _input(event):
	if event.is_action_pressed("click"):
		click_var = true

func _ready():
	$Sprite.frame = current_frame

func set_current_frame(frame: int):
	current_frame = frame
	$Sprite.frame = current_frame

func _animate_activation():
	self.set_current_frame(self.activated_frame)




func _on_Area2D_mouse_entered(): 
	$Pointer.visible = true
	



func _on_Area2D_mouse_exited():
	$Pointer.visible = false


func _on_Area2D_body_entered(body):
	if click_var && infected_value:
		emit_signal("infected",infected_value,2)
		infected_value = false
	elif click_var:
		emit_signal("infected",infected_value,1)
		infected_value = true
