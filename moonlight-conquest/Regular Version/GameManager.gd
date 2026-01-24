extends Node

var player_data = [] 
var current_player_index = 0
var max_players = 6

# List your scenes here in the exact order you want them to appear
var selection_scenes = [
	"res://Regular Version/playerone.tscn",
	"res://Regular Version/playertwo.tscn",
	"res://Regular Version/playerthree.tscn",
	"res://Regular Version/playerfour.tscn",
	"res://Regular Version/playerfive.tscn",
	"res://Regular Version/playersix.tscn"
]

var realm_counts = {"air": 0, "dream": 0, "earth": 0, "fire": 0, "water": 0, "time": 0}

func save_player(player_name: String, realm_name: String):
	player_data.append({"name": player_name, "realm": realm_name})
	realm_counts[realm_name] += 1
	print("Saved Player %d: %s - %s" % [current_player_index + 1, player_name, realm_name])

func go_to_next_player():
	current_player_index += 1
	
	if current_player_index < max_players:
		get_tree().change_scene_to_file(selection_scenes[current_player_index])
	else:
		# All players done, go to story
		get_tree().change_scene_to_file("res://Regular Version/story.tscn")

func reset_game():
	player_data.clear()
	current_player_index = 0
	realm_counts = {"air": 0, "dream": 0, "earth": 0, "fire": 0, "water": 0, "time": 0}
