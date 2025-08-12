extends Sprite2D

@export var player_path: NodePath
@export var radius: float = 32.0

var player: Node2D

func _ready():
	player = get_node(player_path)

func _process(delta):
	if not player:
		return
	
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - player.global_position).normalized()

	var current_radius = radius


	global_position = player.global_position + direction * current_radius
	rotation = direction.angle()
	flip_v = direction.x < 0
	
