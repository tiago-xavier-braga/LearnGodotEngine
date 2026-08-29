extends Node3D

@export var roads: Array[PackedScene] = []
@export var spawner_number: int = 100
@export var road_length: float = 20.0

@onready var spawned: Array[Node3D] = []

func _ready() -> void:
	if roads.is_empty():
		return
	for i in range(spawner_number):
		_spawn_road(roads[i % roads.size()], i)

func _spawn_road(road_scene: PackedScene, index: int) -> void:
	var road := road_scene.instantiate() as Node3D
	add_child(road)
	road.position = Vector3(0, 0, -index * road_length)
	spawned.append(road)
