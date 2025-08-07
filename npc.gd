extends CharacterBody2D

@onready var dialogue_bubble = get_node("/root/YourUIRoot/DialogueBubble")  # Adjust this path to your UI node
@onready var bubble_box = dialogue_bubble.get_node("BubbleBox")
@onready var dialogue_label = bubble_box.get_node("DialogueLabel")
@onready var proximity_area = $ProximityArea

var dialogue_text := "Hey there! I'm an NPC."

func _ready():
	dialogue_bubble.visible = false
	dialogue_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	dialogue_label.size.x = 160
	proximity_area.body_entered.connect(self._on_body_entered)
	proximity_area.body_exited.connect(self._on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		show_bubble(body)

func _on_body_exited(body):
	if body.is_in_group("player"):
		hide_bubble()

func show_bubble(player):
	dialogue_label.text = dialogue_text
	await get_tree().process_frame
	var text_size = dialogue_label.get_minimum_size()
	var padding = Vector2(16, 12)
	bubble_box.custom_minimum_size = text_size + padding

	var viewport = get_viewport()
	var canvas_transform = viewport.get_canvas_transform()
	var screen_pos = canvas_transform.xform(global_position)

	var player_left = player.global_position.x < global_position.x
	if player_left:
		dialogue_bubble.position = screen_pos + Vector2(-bubble_box.custom_minimum_size.x - 10, -10)
		bubble_box.scale.x = -1
		dialogue_label.scale.x = -1
	else:
		dialogue_bubble.position = screen_pos + Vector2(40, -10)
		bubble_box.scale.x = 1
		dialogue_label.scale.x = 1

	dialogue_bubble.visible = true

func hide_bubble():
	dialogue_bubble.visible = false
