extends Node3D

var draggable

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton and event.is_pressed():
		
		print("click")
		
		var params = PhysicsRayQueryParameters3D.new()
		params.from = get_viewport().get_camera_3d().project_ray_origin(event.position)
		params.to = get_viewport().get_camera_3d().project_position(event.position, 1000)
		var worldspace = get_world_3d().direct_space_state
		var collision = worldspace.intersect_ray(params)
		
		if collision:
			print(collision)
			if collision["collider"] is Draggable:
				draggable = collision["collider"]
				draggable.dragging = true
	
	elif event is InputEventMouseButton and !event.is_pressed() and draggable:
		draggable.dragging = false
		draggable = null
