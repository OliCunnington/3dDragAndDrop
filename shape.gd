extends Node3D
class_name  Shape

var target
var t = 0

@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _process(delta: float) -> void:
	if target:
		t += delta
		mesh_instance_3d.global_position = global_position.lerp(target, t)


func run_animation(pos : Vector3):
	target = Vector3(pos.x, 0, pos.z)
	animation_player.play("destroy")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		queue_free()
