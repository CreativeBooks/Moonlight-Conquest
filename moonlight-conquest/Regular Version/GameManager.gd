extends Node

var player_data = [] 
var current_player_index = 0
var max_players = 6

# List your scenes here in the exact order you want them to appear
var selection_scenes = [
	"res://playerone.tscn",
	"res://playertwo.tscn",
	"res://playerthree.tscn",
	"res://playerfour.tscn",
	"res://playerfive.tscn",
	"res://playersix.tscn"
]

var realm_counts = {"air": 0, "dream": 0, "earth": 0, "fire": 0, "water": 0, "time": 0}

func save_player(player_name: String, realm_name: String):
	player_data.append({"name": player_name, "realm": realm_name})
	realm_counts[realm_name] += 1
