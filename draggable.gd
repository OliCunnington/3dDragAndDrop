extends CSGSphere3D
class_name Draggable

var dragging = false
var inter

@onready var worldspace = get_world_3d().direct_space_state
@onready var params = PhysicsRayQueryParameters3D.new()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragging:
		var mouse = get_viewport().get_mouse_position()
		params.from = get_viewport().get_camera_3d().project_ray_origin(mouse)
		params.to = get_viewport().get_camera_3d().project_position(mouse, 1000)
		inter = worldspace.intersect_ray(params)
		print(inter)
		var pos = inter["position"]
		position = Vector3(pos.x, 0, pos.z)
