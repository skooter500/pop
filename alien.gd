extends Node3D

@export var explosion_scene:PackedScene=load("Explosion.tscn")

var color:Color

func _ready() -> void:
	var mesh:MeshInstance3D = get_node("mesh") 
	mesh.get_surface_override_material(0).albedo_color = color
	scale = Vector3.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector3.ONE, 1)
	# vary the pitch
	$Synth.pitch_scale = randf_range(0.7, 1.3)


func _on_area_3d_body_entered(body: Node3D) -> void:
	$Explosion.play()
	var exp:GPUParticles3D = explosion_scene.instantiate()
	exp.emitting = true
	exp.material_override.albedo_color = color
	exp.position = position
	get_parent().add_child(exp)
	self.queue_free()
	body.queue_free()
	get_parent().alien_count = get_parent().alien_count + 1
	pass # Replace with function body.
