extends Node3D
class_name  Shape


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func run_animation():
	animation_player.play("destroy")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		queue_free()
