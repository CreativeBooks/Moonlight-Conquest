extends Node2D


var player_data = [] 
var current_player_index = 0

# Configuration
var max_players = 6 
var picks_per_realm = 1 


var realm_counts = {
	"Fire": 0, "Water": 0, "Earth": 0, 
	"Air": 0, "Time": 0, "Dream": 0
}

func is_realm_available(realm_name: String) -> bool:
	return realm_counts[realm_name] < picks_per_realm
