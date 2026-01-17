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
	#title_label.text = "Player " + str(GameManager.current_player_index + 1)
	
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
	# 1. Get the name from the input box
	var entered_name = name_edit.text.strip_edges()
	
	# 2. Validation
	if entered_name == "":
		name_edit.placeholder_text = "name required!"
		return

	# 3. Get the realm name from the button name (e.g., "airbutton" -> "air")
	var realm_name = button.name.replace("button", "").to_lower()

	# 4. Save Player 2's data to the GameManager
	# This adds to the realm_counts so the NEXT scene knows this realm is taken.
	GameManager.save_player(entered_name, realm_name)
	
	# 5. CRITICAL FIX: Move to Player THREE index and scene
	GameManager.current_player_index = 2 # 0 is P1, 1 is P2, 2 is P3
	get_tree().change_scene_to_file("res://Regular Version/playerthree.tscn")
