# Contributors
# - willnationsdev

extends Container

signal mouse_hovering(position, velocity)
signal mouse_left_clicked(position, velocity)
signal mouse_right_clicked(position, velocity)

export var hover_emission_rate = 1.0

var is_hovering = false
var _hover_accumulator = 0.0
var last_mouse_position = Vector2(0,0)

func _ready():
	connect("mouse_entered", self, "on_mouse_entered")
	connect("mouse_exited", self, "on_mouse_exited")
	_setup_actions()

func _fixed_process(p_delta):
	_hover_accumulator += p_delta
	
	# Needed because Input.get_last_mouse_speed() does not update when not moving between frames.
	# Ergo, a steady mouse will not return Vector2(0,0).
	var true_speed = Vector2(0,0)
	
	if is_hovering:
		if _hover_accumulator >= hover_emission_rate:
			if get_viewport().get_mouse_position() != last_mouse_position:
				true_speed = Input.get_last_mouse_speed()
			
			last_mouse_position = get_viewport().get_mouse_position()
			
			emit_signal("mouse_hovering", last_mouse_position, true_speed)
			
			while _hover_accumulator >= hover_emission_rate:
				_hover_accumulator -= hover_emission_rate
		
		if Input.is_action_just_pressed("hover_container_left_click"):
			emit_signal("mouse_left_clicked", last_mouse_position, true_speed)
		if Input.is_action_just_pressed("hover_container_right_click"):
			emit_signal("mouse_right_clicked", last_mouse_position, true_speed)

func on_mouse_entered():
	is_hovering = true

func on_mouse_exited():
	is_hovering = false

func _setup_actions():
	var lc = "hover_container_left_click"
	var rc = "hover_container_right_click"
	
	if not InputMap.has_action(lc):
		InputMap.add_action(lc)
		var ev = InputEventMouseButton.new()
		ev.set_button_index(BUTTON_LEFT)
		ev.set_doubleclick(false)
		ev.set_factor(1)
		InputMap.action_add_event(lc,ev)
	
	if not InputMap.has_action(rc):
		InputMap.add_action(rc)
		var ev = InputEventMouseButton.new()
		ev.set_button_index(BUTTON_RIGHT)
		ev.set_doubleclick(false)
		ev.set_factor(1)
		InputMap.action_add_event(rc,ev)

func is_hovering():
	return is_hovering

func get_last_mouse_position():
	return last_mouse_position