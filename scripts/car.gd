class_name Car
extends RigidBody3D

@export var acceleration: float = 10.0
@export var max_speed: float = 25.0
@export var lane_distance: float = 2.5
@export var lane_limit: int = 1
@export var lane_speed: float = 10.0

var _current_lane: int = 0

func _physics_process(delta: float) -> void:
	_drive_forward()
	_track_lane(delta)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("move_left"):
		_change_lane(-1)
	elif event.is_action_pressed("move_right"):
		_change_lane(1)


func _drive_forward() -> void:
	var forward := -global_basis.z
	if linear_velocity.dot(forward) >= max_speed:
		return

	apply_central_force(forward * acceleration * mass)

func _change_lane(direction: int) -> void:
	_current_lane = clampi(_current_lane + direction, -lane_limit, lane_limit)


func _track_lane(delta: float) -> void:
	var target_x := _current_lane * lane_distance
	linear_velocity.x = clampf(
		(target_x - global_position.x) / delta, -lane_speed, lane_speed)
