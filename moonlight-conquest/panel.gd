extends Panel

@onready var card_container = $CardContainer
@onready var title_label = $TitleLabel
@onready var close_button = $CloseButton

func _ready():
	close_button.pressed.connect(func(): visible = false)
	visible = false

func show_hand(player_index: int):
	var screen_size = get_viewport().get_visible_rect().size
	size = Vector2(800, 500)
	position = (screen_size - size) / 2
	
	title_label.text = "Player %d's Hand" % player_index
	
	for child in card_container.get_children():
		child.queue_free()
	
	var hand = PlayerHandManager.get_hand(player_index)
	for card in hand:
		var card_panel = PanelContainer.new()
		card_panel.custom_minimum_size = Vector2(80, 110)
		
		var overlay = Control.new()
		overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		card_panel.add_child(overlay)
		
		# Find Sword1 (card back) and SwordBack (card front)
		var sword1 = null
		var sword_back = null
		for child in card.get_children():
			if child.name == "Sword1":
				sword1 = child
			elif "Back" in child.name:
				sword_back = child
		
		# Show Sword1 texture (the card back)
		var texture_rect = TextureRect.new()
		texture_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		texture_rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
		if sword1:
			texture_rect.texture = sword1.texture
		overlay.add_child(texture_rect)
		
		# Add labels from Sword1's children with scaled positions
		if sword1:
			var card_display_size = Vector2(80, 110)
			var original_texture_size = sword1.texture.get_size()
			var scale_factor = min(
				card_display_size.x / original_texture_size.x,
				card_display_size.y / original_texture_size.y
			)
			
			for grandchild in sword1.get_children():
				if grandchild is Label:
					var label = Label.new()
					label.text = grandchild.text
					# Scale position relative to Sword1
					label.position = Vector2(
						(grandchild.position.x + original_texture_size.x / 2) * scale_factor,
						(grandchild.position.y + original_texture_size.y / 2) * scale_factor
					)
					var original_font_size = grandchild.get_theme_font_size("font_size")
					label.add_theme_font_size_override("font_size", max(6, int(original_font_size * scale_factor)))
					overlay.add_child(label)
		
		card_container.add_child(card_panel)
	
	visible = true

func _on_close_pressed():
	visible = false
