extends Control

@onready var grid_container = $GridContainer
@onready var title_label = $Label2 # This is your "Player One" text

func _ready():
	update_ui()
	# Connect all buttons in the grid to one function
	for button in grid_container.get_children():
		if button is Button:
			button.pressed.connect(_on_realm_selected.bind(button))

func update_ui():
	# Update the Title to show current player
	title_label.text = "Player " + str(GameManager.current_player_index + 1)
	
	# Check each button: Gray it out if already taken
	for button in grid_container.get_children():
		var realm_name = button.name.replace("button", "") # e.g. "fire"
		
		if GameManager.realm_counts.get(realm_name, 0) >= GameManager.picks_per_realm:
			button.disabled = true
			button.modulate = Color(0.3, 0.3, 0.3) # Makes it dark/gray
		else:
			button.disabled = false
			button.modulate = Color(1, 1, 1) # Normal color

func _on_realm_selected(button):
	var realm_name = button.name.replace("button", "")
	
	# Logic for choosing names (could trigger a popup or just use the button press)
	# For now, let's assume choosing the realm finishes the turn:
	
	GameManager.save_choice(realm_name) # You'll add this function to GameManager
	
	if GameManager.current_player_index < GameManager.max_players - 1:
		GameManager.current_player_index += 1
		update_ui() # Refresh the page for next player
	else:
		get_tree().change_scene_to_file("res://YourGameScene.tscn")
