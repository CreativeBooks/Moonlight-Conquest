extends Control

@onready var card_front = $Sword1
@onready var card_back = $SwordBack
@onready var damage_bar = $Sword1/Dragondamagebar

var is_flipped = false
var is_animating = false

func _ready():
	# Start with card showing the back
	card_front.visible = false
	card_back.visible = true
	
	# Make sure the card itself is visible
	self.visible = true
	
	# Debug: print to confirm the script is running
	print("Card script loaded")
	print("Card front: ", card_front)
	print("Card back: ", card_back)
	
func flip_card():
	if is_animating:
		false
	
	is_animating = true
	var tween = create_tween()
	tween.set_parallel(false)
	
	tween.tween_property(self, "scale:x", 0.0, 0.2).set_ease(Tween.EASE_IN)
	
	tween.tween_callback(_swap_card_sides)
	
	tween.tween_property(self, "scale:x", 1.0, 0.2).set_ease(Tween.EASE_OUT)
	
	tween.tween_callback(_finish_animation)
	
	is_flipped = !is_flipped
	
func _swap_card_sides():
	if is_flipped:
		card_front.visible = false
		card_back.visible = true
	else:
		card_front.visible = true
		card_back.visible = false
		
func _finish_animation():
	is_animating = false
	
func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()
		# Simple click detection (you can make this more precise)
		if mouse_pos.distance_to(global_position) < 200:
			flip_card()
	
