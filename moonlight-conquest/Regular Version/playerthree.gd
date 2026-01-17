extends Control

@onready var name_edit = $name
@onready var title_label = $Label2

func _ready():
	update_ui()
	
	# Connect every button that is a direct child of 'Regular'
	for child in get_children():
		# This checks if the node is a TextureButton and follows your naming style
		if child is TextureButton and child.name.ends_with("button"):
			child.pressed.connect(_on_realm_selected.bind(child))

func update_ui():
	# Update Title for current player (Player 1, Player 2, etc.)
	title_label.text = "Player " + str(GameManager.current_player_index + 1)
	
	# Clear the name input box for the next person
	if name_edit:
		name_edit.clear()
	
	# Loop through children to handle graying out taken realms
	for child in get_children():
		if child is TextureButton and child.name.ends_with("button"):
			var realm_name = child.name.replace("button", "").to_lower()
			
			# Disable the button if it has already been picked in GameManager
			if GameManager.realm_counts.get(realm_name, 0) >= 1:
				child.disabled = true
				child.modulate = Color(0.2, 0.2, 0.2, 0.8) # Darker gray
			else:
				child.disabled = false
				child.modulate = Color(1, 1, 1, 1) # Normal color

func _on_realm_selected(button):
	# 1. Create the variable (Only use 'var' once!)
	var entered_name = name_edit.text.strip_edges()
	
	# 2. Validation: Ensure they typed something
	if entered_name == "":
		name_edit.placeholder_text = "name required!"
		return

	# 3. Get the realm name
	var realm_name = button.name.replace("button", "").to_lower()

	# ... (Keep your name validation and saving logic at the top) ...
	
	GameManager.save_player(entered_name, realm_name)
	
	GameManager.current_player_index = 3
	
	get_tree().change_scene_to_file("res://Regular Version/playerfour.tscn")
