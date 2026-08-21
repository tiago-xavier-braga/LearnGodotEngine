class_name ObjectFollow
extends Node3D

@export var target: Node3D
@export var axis_ignored: Vector3

func _process(_delta: float) -> void:
	var follow_position = (
		target.global_position * (Vector3.ONE - axis_ignored)
		+ global_position * axis_ignored
	)
	global_position = follow_position
