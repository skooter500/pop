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

@onready var left = $"../left"
@onready var right = $"../right"
@onready var left_elastic = $"../left/left_elastic"
@onready var right_elastic = $"../right/right_elastic"
@onready var center = $"center_collision"

func _process(delta):
	if p > 0:
		held = true
	else:
		held = false
	if held:
		## Calculate left side of catepult
		var to_cent = right_hand.global_position - left.global_position
		
		var mid = left.global_position + (to_cent * 0.5)
		var len = to_cent.length()
		left_elastic.get_node("left_elastic").scale = Vector3(0.1, 0.1, len)		
		left_elastic.set_visible(true)
		left_elastic.global_position = mid
		left_elastic.global_basis = Basis.looking_at(to_cent)		
		
		## Calculate left side of catepult
		#to_cent = right.global_position - right_hand.global_position
		#
		#mid = right.global_position + (to_cent * 0.5)
		#len = to_cent.length()
		#right_elastic.set_visible(true)
		#right_elastic.global_position = mid
		#right_elastic.global_basis = Basis.looking_at(right.global_position)		
		#right_elastic.get_parent().scale = Vector3(0.1, 0.1, len)
	else:
		left_elastic.visible = false
		right_elastic.visible = false
		
	
	# print(p)
