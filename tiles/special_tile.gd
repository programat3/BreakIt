class_name SpecialTile 
extends Tile

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

func _ready():
	$Sprite.frame = current_frame

func set_current_frame(frame: int):
	current_frame = frame
	$Sprite.frame = current_frame

func _animate_activation():
	self.set_current_frame(self.activated_frame)


