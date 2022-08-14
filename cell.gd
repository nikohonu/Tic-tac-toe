extends Sprite

var state = 0 setget set_state
var index = Vector2()

signal on_cell_click(index)


func set_state(new_state):
	state = new_state
	region_rect.position.x = state * 180
	
func init(position: Vector2):
	index = position
	self.position.x = (index.x * 180) + 90
	self.position.y = (index.y * 180) + 90
	
func _ready():
	pass

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton && event.pressed && event.button_index == 1):
		emit_signal('on_cell_click', index)
