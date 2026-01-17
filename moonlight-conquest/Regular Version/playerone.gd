extends Node2D

@onready var name_edit = $NameInput
@onready var title_label = $Label2
@onready var grid_container = $GridContainer

func _ready():
	update_ui()
	
	# This connects all your buttons (air, dream, etc.) to the selection logic
	for button in grid_container.get_children():
		if button is Button:
			button.pressed.connect(_on_realm_selected.bind(button))

func update_ui():
	# Change "Player One" to "Player Two", etc. based on the GameManager
	title_label.text = "Player " + str(GameManager.current_player_index + 1)
	name_edit.clear()
	
	# Gray out buttons that were already picked by previous players
	for button in grid_container.get_children():
		var realm_name = button.name.replace("button", "")
		if GameManager.realm_counts.get(realm_name, 0) >= 1:
			button.disabled = true
			button.modulate = Color(0.2, 0.2, 0.2, 0.8) # Darker/Grayed out
		else:
			button.disabled = false
			button.modulate = Color(1, 1, 1, 1) # Normal

func _on_realm_selected(button):
	var entered_name = name_edit.text.strip_edges()
	
	# 1. Validation: Ensure they typed a name before clicking a card
	if entered_name == "":
		# You could add a shake animation here later!
		name_edit.placeholder_text = "NAME REQUIRED!" 
		return

	var realm_name = button.name.replace("button", "")

	# 2. Save the data to the GameManager
	GameManager.player_data.append({
		"name": entered_name,
		"realm": realm_name
	})
	
	# 3. Mark this realm as taken
	GameManager.realm_counts[realm_name] = 1
	
	# 4. Move to next player or start game
	if GameManager.current_player_index < 5: # For a 6 player game (0 to 5)
		GameManager.current_player_index += 1
		update_ui() # Refresh the screen for the next player
	else:
		start_game()

func start_game():
	get_tree().change_scene_to_file("res://Regular Version/playertwo.tscn")
