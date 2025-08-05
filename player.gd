extends CharacterBody2D

const SPEED = 200.0


var screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
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
	velocity = input_vector * SPEED
	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "run"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "run"
		if $AnimatedSprite2D.flip_h == false:
			$AnimatedSprite2D.flip_h = velocity.x < 0
		else:
			$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.stop()
		$AnimatedSprite2D.animation = "idle"
	
	
