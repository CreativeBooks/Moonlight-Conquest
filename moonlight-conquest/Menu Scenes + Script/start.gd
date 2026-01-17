extends Node2D


# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_regularbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Regular Version/playerone.tscn")


func _on_alliedbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://Allied Version/allied.tscn")
