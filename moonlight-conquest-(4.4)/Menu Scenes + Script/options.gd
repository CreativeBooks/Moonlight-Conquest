extends Node2D


func _on_optionsreturnbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Menu Scenes + Script/node_2d.tscn")
