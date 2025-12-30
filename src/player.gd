extends StaticBody3D

var action_manager = ActionManager.new({
	"move": [move, undo_move]
})

func _init() -> void:
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print('ready')

func get_input_direction() -> Vector2:
	#if $Timer.time_left != 0:
		#return Vector2()
	
	var v = Vector2()
	if Input.is_action_just_pressed("playerDown"):
		v.y += 1
	if Input.is_action_just_pressed("playerUp"):
		v.y -= 1
	if Input.is_action_just_pressed("playerLeft"):
		v.x -= 1
	if Input.is_action_just_pressed("playerRight"):
		v.x += 1
		
	if v.x != 0 and v.y != 0:
		return Vector2()
	#if v != Vector2.ZERO:
		#$Timer.start()
	return v

func move(dir):
	var grid_pos = Global.get_grid_pos(self)
	var new_pos = grid_pos + dir
	
	var collider = Global.grid_check(new_pos)
	if collider == null:
		Global.move_to_grid_pos(self, new_pos)
	else:
		if collider.is_in_group("wall"):
			print('wall!')
		
		if collider.is_in_group("pushable"):
			if collider.push(dir):
				Global.move_to_grid_pos(self, new_pos)

func undo_move(dir):
	var grid_pos = Global.get_grid_pos(self)
	var new_pos = grid_pos - dir
	Global.move_to_grid_pos(self, new_pos)


func _physics_process(_delta: float) -> void:
	var input_direction = get_input_direction()
	if Input.is_action_just_pressed("undo"):
		Global.undo()
	
	if input_direction != Vector2.ZERO:
		Global.time_index += 1
		action_manager.do_action("move", [input_direction])
