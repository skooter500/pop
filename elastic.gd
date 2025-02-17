extends Area3D

var right_hand:XRController3D

var held = false

var p = 0

func input_float_changed(name, value):
	print(name)
	p = value
	pass

func _ready():
	right_hand = $"../../XROrigin3D/right"
	right_hand.input_float_changed.connect(input_float_changed)
	imaginary_ball = ball_scene.instantiate()
	get_tree().get_root().add_child(imaginary_ball)
	imaginary_ball.visible = true
	imaginary_ball.mass = 0


@onready var left = $"../left"
@onready var right = $"../right"
@onready var left_elastic = $"../left/left_elastic"
@onready var right_elastic = $"../right/right_elastic"
@onready var center = $"center_collision"

@export var ball_scene:PackedScene
@export var imaginary_ball_scene:PackedScene

@export var power:float = 1000

	
var imaginary_ball

func _process(delta):
	if p > 0:
		held = true
	else:
		if held:
			$"../Stretch".play()

			var to_cent = right_hand.global_position - center.global_position
			var dist = to_cent.length()		
			
			var ball = ball_scene.instantiate()
			ball.global_position = right_hand.global_position
			var dir = center.global_position - right_hand.global_position
			dir = dir.normalized()
			ball.apply_force(dir * power * dist)
			get_tree().get_root().add_child(ball)
		held = false
	if held:
		## Calculate left side of catepult
		var to_cent = right_hand.global_position - left.global_position
		
		var mid = left.global_position + (to_cent * 0.5)
		var len = to_cent.length()
		left_elastic.get_node("left_elastic").scale = Vector3(0.01, 0.01, len)		
		left_elastic.set_visible(true)
		left_elastic.global_position = mid
		left_elastic.global_basis = Basis.looking_at(to_cent)		
		
		to_cent = right_hand.global_position - right.global_position
		
		mid = right.global_position + (to_cent * 0.5)
		len = to_cent.length()
		right_elastic.get_node("right_elastic").scale = Vector3(0.01, 0.01, len)		
		right_elastic.set_visible(true)
		right_elastic.global_position = mid
		right_elastic.global_basis = Basis.looking_at(to_cent)		
		
		imaginary_ball.global_position = right_hand.global_position
		imaginary_ball.visible = true
		
	else:
		left_elastic.visible = false
		right_elastic.visible = false
		imaginary_ball.visible = false
		
	
	# print(p)
