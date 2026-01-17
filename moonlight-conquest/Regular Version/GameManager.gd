extends Node2D  

var player_data = [] 
var current_player_index = 0

# Configuration
var max_players = 6 
var picks_per_realm = 1 

var realm_counts = {
	"air": 0, "dream": 0, "earth": 0, 
	"fire": 0, "water": 0, "time": 0
}

func is_realm_available(realm_name: String) -> bool:
	return realm_counts.get(realm_name, 0) < picks_per_realm

func save_player(player_name: String, realm_name: String):
	player_data.append({
		"name": player_name,
		"realm": realm_name
	})
	realm_counts[realm_name] += 1

func reset_game_data():
	player_data.clear()
	current_player_index = 0
	for key in realm_counts.keys():
		realm_counts[key] = 0
