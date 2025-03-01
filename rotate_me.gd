extends Node3D

func _process(delta):
	rotate_y(delta)

func _ready() -> void:
	scale = Vector3.ZERO
	var tween = create_tween().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale", Vector3.ONE, 1)


func _on_area_3d_body_entered(body: Node3D) -> void:
	$"../alien/Voicesound1".play()
	pass # Replace with function body.
