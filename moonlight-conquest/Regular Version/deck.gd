extends Node2D

var deck = []

func _ready():
	for card in get_children():
		deck.append(card)
	shuffle_deck()
	print("Deck has ", deck.size(), " cards")

func shuffle_deck():
	deck.shuffle()

func draw_card():
	if deck.size() == 0:
		print("Deck is empty!")
		return null
	var card = deck.pop_back()
	return card
