class_name Car
extends RigidBody3D

## Player car for the endless runner.
##
## Drives itself forward along its local -Z axis (Godot's forward) by applying
## a central force every physics tick, and coasts once it reaches [member max_speed].


## Target acceleration in m/s². Converted to a force with F = m * a, so changing
## [member RigidBody3D.mass] in the Inspector does not invalidate this tuning.
@export var acceleration: float = 12.0

## Forward speed cap in m/s (25 m/s ≈ 90 km/h). Above it the car stops
## accelerating and simply coasts.
@export var max_speed: float = 25.0


func _physics_process(_delta: float) -> void:
	var forward := -global_basis.z
	var forward_speed := linear_velocity.dot(forward)
	if forward_speed >= max_speed:
		return

	apply_central_force(forward * acceleration * mass)
