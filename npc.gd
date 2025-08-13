extends CharacterBody2D

var is_chatting = false
var player_in_area = false

func _ready() -> void:
	add_to_group("interaction")
	if Dialogic.has_signal("dialogue_ended"):
		Dialogic.connect("dialogue_ended", Callable(self, "_on_dialogue_ended"))

	var character_resource = load("res://addons/dialogic/Characters/NPC.dch")

func _process(delta: float) -> void:
	if player_in_area and not is_chatting:
		if Input.is_action_just_pressed("e"):
			run_dialogue("timeline") 
	$AnimatedSprite2D.play("idle")

func run_dialogue(dialogue_string):
	is_chatting = true
	Dialogic.start(dialogue_string)

func _on_dialogue_ended():
	is_chatting = false

func _on_proximity_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = true

func _on_proximity_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_area = false
