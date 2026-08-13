class_name Car
extends RigidBody3D

## Player car for the endless runner.
##
## Drives itself forward along its local -Z axis (Godot's forward) by applying
## a central force every physics tick, and coasts once it reaches [member max_speed].
##
## Steering is lane-based, not a turn: the car keeps pointing dead ahead and
## slides sideways between the fixed X positions in [member lane_positions].
## All three angular axes are locked in the scene, so it can neither tip nor
## yaw off course.


## Target acceleration in m/s². Converted to a force with F = m * a, so changing
## [member RigidBody3D.mass] in the Inspector does not invalidate this tuning.
@export var acceleration: float = 12.0

## Forward speed cap in m/s (25 m/s ≈ 90 km/h). Above it the car stops
## accelerating and simply coasts.
@export var max_speed: float = 25.0

## World-space X of every lane, left to right. Must match the road built in the
## level: three 2.5 m lanes on a 7.5 m road.
@export var lane_positions: PackedFloat32Array = PackedFloat32Array([-2.5, 0.0, 2.5])

## Natural frequency (rad/s) of the spring that pulls the car into its lane.
## Higher snaps harder; 6.0 settles a lane change in roughly 0.8 s.
@export var lane_change_sharpness: float = 6.0

var _lane_index: int = 0


func _ready() -> void:
	# Read the starting lane off the car's placement in the level, so dragging
	# it in the editor can never desync the scene from the script.
	_lane_index = _nearest_lane_index(global_position.x)


func _unhandled_input(event: InputEvent) -> void:
	# One lane per press. is_action_pressed() ignores key repeat by default, so
	# holding A does not walk the car across the whole road.
	if event.is_action_pressed("move_left"):
		_change_lane(-1)
	elif event.is_action_pressed("move_right"):
		_change_lane(1)


func _physics_process(_delta: float) -> void:
	_drive_forward()
	_hold_lane()


## Steps one lane in [param direction] (-1 left, +1 right). Clamped, so pressing
## further at the outer lanes does nothing instead of wrapping around.
func _change_lane(direction: int) -> void:
	_lane_index = clampi(_lane_index + direction, 0, lane_positions.size() - 1)


func _drive_forward() -> void:
	var forward := -global_basis.z
	if linear_velocity.dot(forward) >= max_speed:
		return

	apply_central_force(forward * acceleration * mass)


## Critically damped spring on the world X axis: the first term pulls toward the
## lane, the second bleeds off sideways velocity as the car arrives, so it
## settles without overshooting or wobbling. Damping is derived from the
## frequency rather than exposed, because the two are not independent — any
## other ratio either oscillates or crawls.
##
## Lanes are world-space, which is only safe because the body's rotation is
## fully locked; unlock an angular axis and this needs the local X axis instead.
func _hold_lane() -> void:
	if lane_positions.is_empty():
		return

	var offset := lane_positions[_lane_index] - global_position.x
	var omega := lane_change_sharpness
	var force_x := (offset * omega * omega - linear_velocity.x * 2.0 * omega) * mass
	apply_central_force(Vector3(force_x, 0.0, 0.0))


func _nearest_lane_index(x: float) -> int:
	var best_index := 0
	var best_distance := INF

	for i in lane_positions.size():
		var distance := absf(lane_positions[i] - x)
		if distance < best_distance:
			best_distance = distance
			best_index = i

	return best_index
