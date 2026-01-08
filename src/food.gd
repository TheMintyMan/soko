extends StaticBody3D


@export var value: int = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_value() -> int:
	return value

func eaten (n:Node3D) -> bool:
	if n == Global.get_player():
		print("food has been eaten by player")
		queue_free()
		return true
	return false
