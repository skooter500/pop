extends RigidBody3D

@export var imaginary = false

func _ready():
	if ! imaginary:
		await get_tree().create_timer(5).timeout
		self.queue_free()
