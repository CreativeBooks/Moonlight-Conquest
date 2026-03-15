extends Node2D
@export var card_name = "blank1"
@export var realm = "air"
@export var rank = 5
@onready var card_back = $Sword6
@onready var card_front = $SwordBack
@onready var damage_bar = $Sword6/Dragondamagebar
var is_flipped := false
var is_animating := false

func _ready():
	card_front.visible = true
	card_back.visible = false

var is_drawn := false  # Add this at the top

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if PlayerHandManager.is_in_hand(self):
			return
		if not is_drawn:
			return
		
		var mouse_pos = get_global_mouse_position()
		var rect = $Sword6.get_global_transform() * $Sword6.get_rect()
		if rect.has_point(mouse_pos):
			if not is_animating:
				flip_card()
				get_viewport().set_input_as_handled()

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
