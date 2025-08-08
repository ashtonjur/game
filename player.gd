extends CharacterBody2D

const SPEED = 100.0

var screen_size = Vector2.ZERO

func _ready():
	screen_size = get_viewport().get_visible_rect().size 

func _physics_process(_delta: float) -> void:
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	
	input_vector = input_vector.normalized()
	velocity.x = input_vector.x * SPEED
	velocity.y = input_vector.y * SPEED

	move_and_slide()

	if velocity.x != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_v = false
	elif velocity.y != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "idle"

	var mouse_pos := get_global_mouse_position()
	$AnimatedSprite2D.flip_h = mouse_pos.x < global_position.x
