extends Node2D

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			raycast_check_for_card()
		else:
			print("Left click released")

func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collision_with_areas = true
	parameters.collision = 1
	var result = space_state.intersect_point(parameters)
	print(result)
