extends Node2D

@export var pushForce = 500
@export var bodyPath: NodePath = ".."

@onready var body: CharacterBody2D = get_node(bodyPath)

func _physics_process(_delta):
	var pushing_bodies = []
	if body.move_and_slide():
		for i in body.get_slide_collision_count():
			var col = body.get_slide_collision(i)
			var collider = col.get_collider()
			if collider is RigidBody2D:
				collider.apply_force(col.get_normal() * -pushForce)
				pushing_bodies.append(collider)
