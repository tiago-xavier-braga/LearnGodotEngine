class_name Car
extends RigidBody3D

@export var acceleration: float = 10.0
@export var max_speed: float = 25.0
@export var lane_distance: float = 2.5
@export var lane_limit: int = 1
@export var lane_speed: float = 10.0
@export var delay_input: float = 0.3

var _current_lane: int = 0
var _can_switch_lane: bool = true

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
	if not _can_switch_lane:
		return
	var new_lane := clampi(_current_lane + direction, -lane_limit, lane_limit)
	if new_lane == _current_lane:
		return
	_current_lane = new_lane
	_can_switch_lane = false
	await get_tree().create_timer(delay_input).timeout
	_can_switch_lane = true


func _track_lane(delta: float) -> void:
	var target_x := _current_lane * lane_distance
	linear_velocity.x = clampf(
		(target_x - global_position.x) / delta, -lane_speed, lane_speed)
