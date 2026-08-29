extends Node3D

@export var car_path: NodePath
@export var obstacle_scenes: Array[PackedScene] = []
@export var spawn_distance: float = 40.0
@export var spawn_interval: float = 1.5
@export var despawn_distance: float = 20.0

@onready var car: CarController = get_node_or_null(car_path)
@onready var _timer: Timer = Timer.new()

var _spawned: Array[Node3D] = []

func _ready() -> void:
	if obstacle_scenes.is_empty() or not car:
		return
	add_child(_timer)
	_timer.wait_time = spawn_interval
	_timer.timeout.connect(_spawn_obstacle)
	_timer.start()

func _spawn_obstacle() -> void:
	_despawn_passed()
	var obstacle_scene: PackedScene = obstacle_scenes[randi() % obstacle_scenes.size()]
	var obstacle := obstacle_scene.instantiate() as Node3D
	add_child(obstacle)
	var lane := randi_range(-car.lane_limit, car.lane_limit)
	obstacle.global_position = Vector3(
		lane * car.lane_distance, 0, car.global_position.z - spawn_distance)
	_spawned.append(obstacle)

func _despawn_passed() -> void:
	for obstacle in _spawned.duplicate():
		if obstacle.global_position.z > car.global_position.z + despawn_distance:
			_spawned.erase(obstacle)
			obstacle.queue_free()
