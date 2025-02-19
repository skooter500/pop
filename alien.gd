extends Node3D

var explosion_scene:PackedScene=preload("explosion.tscn")

var color:Color

func _ready() -> void:
	var mesh:MeshInstance3D = get_node("mesh") 
	mesh.get_surface_override_material(0).albedo_color = color
	scale = Vector3.ZERO
	
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector3.ONE, 1)
	var t:float = 2
	tween.connect("finished", movement)
	# vary the pitch
	$Synth.pitch_scale = randf_range(0.5, 2)
	$Synth.play()
	
func movement():
	var t:float = 2
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)	
	tween.tween_property(self, "position", position + Vector3.FORWARD * 1, t)
	tween.tween_property(self, "position", position + Vector3.UP * 1, t)
	tween.tween_property(self, "position", position + Vector3.RIGHT * 1, t)
	tween.tween_property(self, "position", position + Vector3.DOWN * 1, t)
	tween.tween_property(self, "position", position + Vector3.LEFT * 1, t)
	tween.finished.connect(movement)
	tween.step_finished.connect(move_step)
	
func move_step(i):
	$blip.pitch_scale=randf_range(0.7, 3)
	# $blip.play()

func _process(delta: float) -> void:
	rotate_y(delta)

func _on_area_3d_body_entered(body: Node3D) -> void:
	$"../Explosion".pitch_scale = randf_range(0.5, 3)
	$"../Explosion".play()
	var exp:GPUParticles3D = explosion_scene.instantiate()
	exp.emitting = true
	exp.material_override.albedo_color = color
	exp.position = position
	get_parent().add_child(exp)
	self.queue_free()
	body.queue_free()
	get_parent().alien_count = get_parent().alien_count + 1
	pass # Replace with function body.
