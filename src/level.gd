extends Node
class_name Level
signal win_condition_met

var food_on_grid: int = 0
var frog_home: Node3D = null
var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func register_player(player_node:Node):
	player = player_node
	print("player registered using global")
	
func unregister_player():
	player = null
	print("unregistered player")

func get_player() -> Player:
	if is_instance_valid(player):
		return player
	else:
		return null
		
func register_food() -> void:
	food_on_grid += 1
	
func on_food_eaten() -> void:
	food_on_grid -= 1
	check_win_condition()
	
func register_home(home_node:Node) -> void:
	if (home_node is Home):
		frog_home = home_node
		print("home registered")
	return

func check_win_condition() -> void:
	if (!(food_on_grid == 0 && frog_home == null)):
		print("win check: not yet won")
	
	if(!frog_home):
		return
	
	if food_on_grid == 0 && player.global_position == frog_home.global_position:
		win_condition_met.emit()
		print("win check: won")
	else:
		win_condition_met.emit()
		print("win check: won")
