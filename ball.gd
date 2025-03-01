extends RigidBody3D

@export var imaginary = false

func _ready():
	if ! imaginary:
		var t = create_tween().set_trans(Tween.TRANS_LINEAR)
		var material = $MeshInstance3D.get_surface_override_material(0)
		material = $MeshInstance3D.get_active_material(0).duplicate()
		$MeshInstance3D.set_surface_override_material(0, material)
		material.albedo_color.a = 1
		t.tween_property(material, "albedo_color:a", 0, 5)
		await get_tree().create_timer(5).timeout
		self.queue_free()
