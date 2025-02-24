extends Node3D

var xr_interface
	# when the scene is loaded, assign these variables from the scene
@onready var ufo_spawner = $alien_spawner
@onready var dude = $player

@onready var environment:Environment = $WorldEnvironment.environment

var alien_count:int=0

func _ready():
	
	xr_interface = XRServer.find_interface("OpenXR")
	if xr_interface and xr_interface.is_initialized():
		print("OpenXR initialised successfully")

		# Turn off v-sync!
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)

		# Change our main viewport to output to the HMD
		get_viewport().use_xr = true
		var modes = xr_interface.get_supported_environment_blend_modes()
		if XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND in modes:
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ALPHA_BLEND
		elif XRInterface.XR_ENV_BLEND_MODE_ADDITIVE in modes:
			xr_interface.environment_blend_mode = XRInterface.XR_ENV_BLEND_MODE_ADDITIVE
		else:
			print("ARGH!!!!")
			return false
	else:
		print("OpenXR not initialized, please check if your headset is connected")
	get_window().set_current_screen(1)
	
	get_viewport().transparent_bg = true
	environment.background_mode = Environment.BG_CLEAR_COLOR
	environment.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	get_window().set_current_screen(1)

	next_level()
	pass
	

var target = 0
var level = 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_ESCAPE:
		get_tree().quit()		


func next_level():
	$Spawn.play()
	ufo_spawner.radius = 1
	ufo_spawner.count = level + 1
	ufo_spawner.rate  = level + 1
	# ufo_spawner.position = dude.position
	ufo_spawner.spawn()	
	level = level + 1
	# next target
	target = target + ufo_spawner.count


func _process(delta):
	# if the dude reaches the target, advance to next level
	if alien_count == target:
		next_level()
	pass
