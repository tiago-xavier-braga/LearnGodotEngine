class_name Car
extends RigidBody3D

@export var acceleration: float = 10.0
@export var laneDistance: float = 10.0

var currentLane: int = 0

func _physics_process(_delta : float) -> void:
	_drive_forward()

func _drive_forward() -> void:
	var forward := -global_basis.z
	apply_central_force(forward * acceleration * mass)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		_change_lane(-1)
	elif event.is_action_pressed("move_right"):
		_change_lane(1)
		
func _change_lane(direction: int) -> void:
	if (currentLane > 0 && currentLane < 0):
		return
	
	var xPosition = position.x * direction
	var offset = Vector3(xPosition, position.y, position.z)
	translate(offset)
	
