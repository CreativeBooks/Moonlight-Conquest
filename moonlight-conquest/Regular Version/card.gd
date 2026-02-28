extends Control

@onready var deck = $deck

func _ready():
	pass  # cards handle their own flipping via _input

func _input(event):
	pass  # also handled by each card

#@onready var card_back = $deck/card1/Sword1
#@onready var card_front = $deck/card1/SwordBack
#@onready var damage_bar = $deck/card1/Sword1/Dragondamagebar
#
#
#var is_flipped := false
#var is_animating := false
#
#
#func _ready():
	#card_front.visible = true
	#card_back.visible = false
#
#
#func _input(event):
	#if event is InputEventMouseButton and event.pressed:
		#if not is_animating:
			#flip_card()
#
#
#func flip_card():
	#is_animating = true
#
	#var tween = create_tween()
	#tween.set_trans(Tween.TRANS_CUBIC)
	#tween.set_ease(Tween.EASE_IN_OUT)
#
##Chate 0.9 to a increased number if the flip isn't as desired
	#tween.tween_property(self, "scale:x", 0.9, 0.15)
#
	#tween.tween_callback(Callable(self, "_swap_sides"))
#
	#tween.tween_property(self, "scale:x", 1.0, 0.15)
#
	#tween.finished.connect(_on_finished)
#
#
#func _swap_sides():
	#is_flipped = !is_flipped
#
	#if is_flipped:
		#card_front.visible = false
		#card_back.visible = true
	#else:
		#card_back.visible = false
		#card_front.visible = true
#
#
#func _on_finished():
	#is_animating = false
