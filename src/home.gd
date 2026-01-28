extends Node3D

class_name Home

var player: StaticBody3D
@onready var level_root: Level = get_tree().current_scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_root.register_home(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
