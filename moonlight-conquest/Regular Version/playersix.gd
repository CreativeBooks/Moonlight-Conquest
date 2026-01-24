extends Control

@onready var name_edit = $name
@onready var title_label = $Label2

func _ready():
	update_ui()
	
	# Connect every button that is a direct child
	for child in get_children():
		if child is TextureButton and child.name.ends_with("button"):
			child.pressed.connect(_on_realm_selected.bind(child))

func update_ui():
	# Update Title for current player
	title_label.text = "Player " + str(GameManager.current_player_index + 1)
	
	# Clear the name input box
	if name_edit:
		name_edit.clear()
		name_edit.grab_focus()
	
	# Loop through children to handle graying out taken realms
	for child in get_children():
		if child is TextureButton and child.name.ends_with("button"):
			var realm_name = child.name.replace("button", "").to_lower()
			
			# Disable the button if it has already been picked
			if GameManager.realm_counts.get(realm_name, 0) >= 1:
				child.disabled = true
				child.modulate = Color(0.2, 0.2, 0.2, 0.8) # Darker gray
			else:
				child.disabled = false
				child.modulate = Color(1, 1, 1, 1) # Normal color

func _on_realm_selected(button):
	# Get the name from the input box
	var entered_name = name_edit.text.strip_edges()
	
	# Validation: Ensure they typed something
	if entered_name == "":
		name_edit.placeholder_text = "Name required!"
		return

	# Get the realm name from the button
	var realm_name = button.name.replace("button", "").to_lower()
	
	# Validate realm name exists
	if not GameManager.realm_counts.has(realm_name):
		print("Warning: Unknown realm - " + realm_name)
		return

	# Save player data (this is Player 6, the final player)
	GameManager.save_player(entered_name, realm_name)
	
	# Player 6 is the last player, so go to next player
	# GameManager will automatically go to story.tscn since current_player_index will be 6
	GameManager.go_to_next_player()
