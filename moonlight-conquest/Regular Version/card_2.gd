extends Node2D
@export var card_name = "blank"
@export var realm = "water"
@export var rank = 1
@onready var card_back = $Sword2
@onready var card_front = $SwordBack
@onready var damage_bar = $Sword2/Dragondamagebar
var is_flipped := false
var is_animating := false

func _ready():
	card_front.visible = true
	card_back.visible = false

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var mouse_pos = get_global_mouse_position()
		var rect = $Sword2.get_global_transform() * $Sword2.get_rect()
		if rect.has_point(mouse_pos):  # Only flip THIS card if clicked
			if not is_animating:
				flip_card()
				get_viewport().set_input_as_handled()  # Prevents other cards from also receiving the click

func flip_card():
	is_animating = true
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale:x", 0.9, 0.15)
	tween.tween_callback(Callable(self, "_swap_sides"))
	tween.tween_property(self, "scale:x", 1.0, 0.15)
	tween.finished.connect(_on_finished)

func _swap_sides():
	is_flipped = !is_flipped
	if is_flipped:
		card_front.visible = false
		card_back.visible = true
	else:
		card_back.visible = false
		card_front.visible = true

func _on_finished():
	is_animating = false
