extends StaticBody3D

@export var leap_count: int = 1
var current_height: int

var action_manager = ActionManager.new({
	"move": [move, undo_move]
})

func _init() -> void:
	current_height = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.register_player(self)
	print("current height: ", current_height)
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
		current_height = 0
		Global.move_to_grid_pos(self, new_pos)
	else:
		#if current_height <= 1:
		if collider.is_in_group("food"):
			if collider.eaten(self):
				var food_value: int 
				food_value = collider.get_value()
				leap_count += food_value
				print("yummyy, current leap count is ", leap_count)
		
		if collider.is_in_group("wall"):
			if collider.is_in_group("leapable"):
				if (collider.get_height):
					var collider_height = collider.get_height()
					if collider_height - current_height == 1:
						if leap_count < 1:
							print("cannot leap again")
						else:
							current_height += 1
							leap_count -= 1
							Global.move_to_grid_pos(self, new_pos)
							print("you just leaped")
					elif collider_height - current_height == 0:
						Global.move_to_grid_pos(self, new_pos)
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
