class_name ObjectFollow
extends Node3D

@export var target: Node3D

func _process(_delta: float) -> void:
	global_position.z = target.global_position.z
