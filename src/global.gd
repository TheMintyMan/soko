extends Node3D
signal do_undo

const TILESIZE = 1
var time_index: int = 0
var player_node: Node = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_grid_pos(n:Node3D) -> Vector2:
	assert(n.global_position.x == floor(n.global_position.x))
	assert(n.global_position.z == floor(n.global_position.z))

	return Vector2(
		n.global_position.x/TILESIZE,
		n.global_position.z/TILESIZE
	)

func register_player(player:Node):
	player_node = player
	print("player registered using global")
	
func unregister_player(player:Node):
	player_node = null
	print("unregistered player")
	
func get_player() -> Node:
	if is_instance_valid(player_node):
		return player_node
	else:
		return null

func grid_check(pos:Vector2) -> Node3D:
	$RayCast3D.global_position = Vector3(pos.x*TILESIZE, $RayCast3D.global_position.y, pos.y*TILESIZE)
	$RayCast3D.force_raycast_update()
	return $RayCast3D.get_collider()
	
func move_to_grid_pos(n:Node3D, pos:Vector2):
	if (n.get('current_height') != null):
		n.global_position = Vector3(pos.x, n.current_height, pos.y)
	else:
		n.global_position = Vector3(pos.x, n.global_position.y, pos.y)
	
func undo():
	emit_signal("do_undo")
	time_index -= 1
