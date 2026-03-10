extends Node2D

var deck = []
@onready var card_counter_label = $deckpile/CardCounterLabel

var player_positions = [
	Vector2(1221, 150),   # Player 1 - Top
	Vector2(1750, 350),   # Player 2 - Top Right
	Vector2(1750, 1050),  # Player 3 - Bottom Right
	Vector2(1221, 1250),  # Player 4 - Bottom
	Vector2(690, 1050),   # Player 5 - Bottom Left
	Vector2(690, 350),    # Player 6 - Top Left
]

var player_hands = {0: [], 1: [], 2: [], 3: [], 4: [], 5: []}
var card_offset = Vector2(30, 0)

func _ready():
	print("Deck Ready")
	
	# Load this deck's cards
	_initialize_deck(self)
	
	# Wait one frame so deck2 has finished its _ready()
	await get_tree().process_frame
	
	# Grab and merge deck2's cards
	var deck2_node = get_node("../deck2")
	if deck2_node:
		_merge_deck(deck2_node)
	else:
		print("deck2 not found!")
	
	shuffle_deck()
	print("Combined deck has ", deck.size(), " cards")
	update_card_counter()
	
	distribute_cards_to_players()

func _initialize_deck(deck_node: Node2D):
	for card in deck_node.get_children():
		if card is Sprite2D or card is Label:
			continue
		deck.append(card)
		card.visible = false

func _merge_deck(other_deck_node: Node2D):
	print("Merging: ", other_deck_node.name)
	# Get cards from deck2 via its own deck array
	var other_cards = other_deck_node.get_deck_cards()
	for card in other_cards:
		other_deck_node.remove_child(card)
		add_child(card)
		deck.append(card)
		card.visible = false
	print("After merge, deck size: ", deck.size())

func distribute_cards_to_players():
	print("Distributing 6 cards to each of 6 players...")
	var cards_needed = 36

	if deck.size() < cards_needed:
		print("Not enough cards! Need ", cards_needed, ", have ", deck.size())
		return

	# Deal round-robin
	for round1 in range(6):
		for player_idx in range(6):
			var card = draw_card()
			if card:
				player_hands[player_idx].append(card)
				_place_card_in_hand(card, player_idx, player_hands[player_idx].size() - 1)

	print("Distribution complete!")

func _place_card_in_hand(card, player_idx: int, card_idx: int):
	var base_pos = player_positions[player_idx]
	card.global_position = base_pos + card_offset * card_idx
	card.visible = true
	card.z_index = card_idx + 1

func shuffle_deck():
	deck.shuffle()

func draw_card():
	if deck.size() == 0:
		print("Deck is empty!")
		return null
	var card = deck.pop_back()
	update_card_counter()
	return card

func update_card_counter():
	if card_counter_label:
		card_counter_label.text = str(deck.size())

var draw_count = 0
var circle_radius = 560
var card_slots = {}

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var rect = $deckpile.get_global_transform() * $deckpile.get_rect()
		if rect.has_point(mouse_pos):
			var card = draw_card()
			if card:
				_reveal_card(card)
				get_viewport().set_input_as_handled()

func _reveal_card(card):
	card.visible = true
	card.is_drawn = true
	card.z_index = 10
	
	var table = get_node("/root/Round1/table")
	var center = table.global_position
	
	var slot = draw_count % 6
	var angle = (TAU / 6) * slot - PI / 2
	var pos = center + Vector2(cos(angle), sin(angle)) * circle_radius
	card.global_position = pos - card.get_child(0).position
	
	if not card_slots.has(slot):
		card_slots[slot] = []
	card_slots[slot].append(card)
	
	for c in card_slots[slot]:
		c.visible = false
		c.z_index = 10
		c.global_position = pos - c.get_child(0).position
	card.visible = true
	card.z_index = 11
	draw_count += 1

func cycle_slot(current_card):
	for slot in card_slots:
		var stack = card_slots[slot]
		if stack.has(current_card):
			var idx = stack.find(current_card)
			current_card.visible = false
			var next = stack[(idx + 1) % stack.size()]
			next.visible = true
			next.z_index = 11
			break
#extends Node2D
#
#var deck = []
#@onready var card_counter_label = $deckpile/CardCounterLabel
#
#func _ready():
	#print("Deck Ready")
	#print("Circle position: ", get_node("../table").position)
	#if has_node("deckpile/CardCounterLabel"):
		#card_counter_label = get_node("deckpile/CardCounterLabel")
		#print("Card Counter Label Found")
	#else:
		#print("Card Counter Label Not Found")
	#
	#for card in get_children():
		#if card is Sprite2D or card is Label:  # Skip the deck sprite
			#continue
		#deck.append(card)
		#card.visible = false
	#shuffle_deck()
	#print("Deck has ", deck.size(), " cards")
	#
	#update_card_counter()
	#
#func shuffle_deck():
	#deck.shuffle()
#
#func draw_card():
	#if deck.size() == 0:
		#print("Deck is empty!")
		#return null
	#var card = deck.pop_back()
	#update_card_counter()
	#return card
#
#func update_card_counter():
	#if card_counter_label:
		#var old_text = card_counter_label.text
		#card_counter_label.text = str(deck.size())
		#print("Label updated from '", old_text, "'to '", card_counter_label.text,"'")
#
#func _input(event):
	#if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#var mouse_pos = get_global_mouse_position()
		#var rect = $deckpile.get_global_transform() * $deckpile.get_rect()
		#if rect.has_point(mouse_pos):
			#var card = draw_card()
			#if card:
				#_reveal_card(card)
				#get_viewport().set_input_as_handled()
#
#
##func _reveal_card(card):
	##card.visible = true
	##card.is_drawn = true  # Now the card can be flipped
	##card.global_position = Vector2(300, 300)
	##card.z_index = 10
	#
#var draw_count = 0  # Track how many cards have been drawn
#var circle_center = Vector2(1221, 698)
#var circle_radius = 560 # Adjust to match your circle's radius
#
#var card_slots = {}  # Stores which cards are in each slot
#func _reveal_card(card):
	#card.visible = true
	#card.is_drawn = true
	#card.z_index = 10
	#
	#var table = get_node("/root/Round1/table")
	#var center = table.global_position
	#
	#var slot = draw_count % 6
	#var angle = (TAU / 6) * slot
	#angle -= PI / 2
	#var pos = center + Vector2(cos(angle), sin(angle)) * circle_radius
	#card.global_position = pos - card.get_child(0).position
	#
	## Track cards in each slot
	#if not card_slots.has(slot):
		#card_slots[slot] = []
		#card_slots[slot].append(card)
	#
	## Hide all cards in slot except the new one
	#for c in card_slots[slot]:
		#c.visible = false
		#c.z_index = 10
		#c.global_position = pos - c.get_child(0).position  # Move all to same slot position
	#card.visible = true
	#card.z_index = 11
	#
	#draw_count += 1
#
#func cycle_slot(current_card):
	#for slot in card_slots:
		#var stack = card_slots[slot]
		#if stack.has(current_card):
			#var idx = stack.find(current_card)
			#current_card.visible = false
			#var next = stack[(idx + 1) % stack.size()]
			#next.visible = true
			#next.z_index = 11
			#break
