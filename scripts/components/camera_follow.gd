class_name CameraFollow
extends Camera3D

## Trails [member target] from a fixed world-space offset.
##
## Smoothing is deliberate: the target is a physics body, and copying its
## position verbatim every tick transfers solver jitter straight to the view.


## Node to follow. Assign in the Inspector.
@export var target: Node3D

## World-space offset from the target. Default sits behind (+Z) and above it,
## since the car drives toward -Z.
@export var offset: Vector3 = Vector3(0.0, 4.0, 8.0)

## How quickly the camera closes the gap, in "catch-up per second".
## Higher is snappier; around 3-8 reads well for a runner.
@export var follow_speed: float = 5.0


func _physics_process(delta: float) -> void:
	if target == null:
		return

	var goal := target.global_position + offset
	# Exponential smoothing: framerate-independent, unlike a raw lerp weight.
	var weight := 1.0 - exp(-follow_speed * delta)

	# Depth (Z) is pinned rather than smoothed. Smoothing always trails a
	# constantly-moving target by speed / follow_speed, which at 25 m/s parks
	# the camera ~5 m further back than `offset` claims. Sideways and vertical
	# motion keep the smoothing, where a little lag is what sells a lane change.
	global_position = Vector3(
		lerpf(global_position.x, goal.x, weight),
		lerpf(global_position.y, goal.y, weight),
		goal.z
	)
