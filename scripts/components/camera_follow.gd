class_name CameraFollow
extends Camera3D

@export var target: Node3D
@export var offset: Vector3 = Vector3(0.0, 4.0, 8.0)
@export var follow_speed: float = 5.0


func _physics_process(delta: float) -> void:
	if target == null:
		return

	var goal := target.global_position + offset
	var weight := 1.0 - exp(-follow_speed * delta)

	global_position = Vector3(
		lerpf(global_position.x, goal.x, weight),
		lerpf(global_position.y, goal.y, weight),
		goal.z
	)

	look_at(target.global_position, Vector3.UP)
