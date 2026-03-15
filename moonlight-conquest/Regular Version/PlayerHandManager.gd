extends Node

var hands: Dictionary = {}
var draw_count: int = 0

func _ready():
	for i in 6:
		hands[i] = []

func next_slot() -> int:
	return draw_count % 6

func add_card(card: Node):
	var slot = next_slot()
	hands[slot].append(card)
	draw_count += 1

func get_hand(player_index: int) -> Array:
	return hands.get(player_index, [])

func is_in_hand(card: Node) -> bool:
	for player_index in hands:
		if card in hands[player_index]:
			return true
	return false
