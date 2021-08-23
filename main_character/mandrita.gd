extends KinematicBody2D


var playback
export(int) var speed = 200
var target = Vector2()
var velocity = Vector2()
var current_spores : int


func get_current_spores():
	return self.current_spores


func set_current_spores(ammount):
	self.current_spores = ammount


func _ready():
	playback = $AnimationTree.get("parameters/playback")
	self.target = self.position


func _input(event):
	playback.start("Idle")
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		playback.travel("Idle")
	elif event.is_action_pressed("trigger"):
		playback.travel("break")


func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)
