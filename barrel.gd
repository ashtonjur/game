extends RigidBody2D

@export var damping_factor: float = 0.3

func _physics_process(delta):
	if linear_velocity.length() < 1:
		linear_velocity = Vector2.ZERO
	else:
		linear_velocity = linear_velocity * (1.0 - damping_factor) + Vector2.ZERO * damping_factor
