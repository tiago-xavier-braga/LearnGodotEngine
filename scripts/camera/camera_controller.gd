extends Camera3D

@export var target_path: NodePath
@export var offset: Vector3 = Vector3(0, 3.45, 3.14)
@export var follow_speed: float = 5.0

@onready var target: Node3D = get_node_or_null(target_path)

func _physics_process(delta: float) -> void:
	if not target:
		return
	var target_position := target.global_position + offset
	global_position = global_position.lerp(target_position, follow_speed * delta)
