extends Node3D

var draggable
var inter
var mouse

@onready var worldspace = get_world_3d().direct_space_state
@onready var params = PhysicsRayQueryParameters3D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if draggable:
		mouse = get_viewport().get_mouse_position()
		params.from = get_viewport().get_camera_3d().project_ray_origin(mouse)
		params.to = get_viewport().get_camera_3d().project_position(mouse, 1000)
		inter = worldspace.intersect_ray(params)
		draggable.position = Vector3(inter["position"].x, 0, inter["position"].z)


func _physics_process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		params.from = get_viewport().get_camera_3d().project_ray_origin(event.position)
		params.to = get_viewport().get_camera_3d().project_position(event.position, 1000)
		var collision = worldspace.intersect_ray(params)
		if collision and collision["collider"] is Shape:
				draggable = collision["collider"]
	
	elif event is InputEventMouseButton and !event.is_pressed() and draggable:
		draggable = null


func _on_area_3d_mouse_entered() -> void:
	print("mouse entered")#
	if draggable:
		draggable.run_animation()
		draggable = null
