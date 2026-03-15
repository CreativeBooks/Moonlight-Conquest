extends CanvasLayer

@onready var hand_popup = $PlayerHandviewer/Panel

func _ready():
	for i in 6:
		var btn = get_node("PlayerButton%d" % i)
		btn.pressed.connect(func(): hand_popup.show_hand(i))
