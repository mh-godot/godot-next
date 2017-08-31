# Contributors:
# - willnationsdev
#
# Description:
# HoverContainer is a simple container that emits signals when left/right 
# mouse clicks occur over it as well as periodic emissions while the mouse
# is hovering over it. The rate at which hover signals are emitted can be
# controlled from the editor.

extends Container

signal mouse_hover(p_position, p_velocity)
signal mouse_left_click(p_position, p_velocity)
signal mouse_right_click(p_position, p_velocity)

export var _hover_emission_rate = 1.0 setget set_hover_emission_rate, get_hover_emission_rate

var _is_hovering = false setget , is_hovering
var _hover_accumulator = 0.0
var _last_mouse_position = Vector2(0,0) setget , get_last_mouse_position

var _lc = "hover_container_left_click"
var _rc = "hover_container_right_click"
var _is_left_clicking = false setget , is_left_clicking
var _is_right_clicking = false setget , is_right_clicking

func _ready():
	connect("mouse_enter", self, "_on_mouse_enter")
	connect("mouse_exit", self, "_on_mouse_exit")
	_setup_actions()
	set_fixed_process(true)

func _fixed_process(p_delta):
	_hover_accumulator += p_delta
	
	# Needed because Input.get_mouse_speed() does not update when not
	# moving between frames. Ergo, a steady mouse will not return Vector2(0,0).
	var true_speed = Vector2(0,0)
	
	if _is_hovering:
		if _hover_accumulator >= _hover_emission_rate:
			if get_viewport().get_mouse_pos() != _last_mouse_position:
				true_speed = Input.get_mouse_speed()
			
			_last_mouse_position = get_viewport().get_mouse_pos()
			
			emit_signal("mouse_hover", _last_mouse_position, true_speed)
			
			while _hover_accumulator >= _hover_emission_rate:
				_hover_accumulator -= _hover_emission_rate
		
		if not _is_left_clicking:
			if Input.is_action_pressed(_lc):
				_is_left_clicking = true
				emit_signal("mouse_left_click", _last_mouse_position, true_speed)
		elif not Input.is_action_pressed(_lc):
			_is_left_clicking = false
			
		if not _is_right_clicking:
			if Input.is_action_pressed(_rc):
				_is_right_clicking = true
				emit_signal("mouse_right_click", _last_mouse_position, true_speed)
		elif not Input.is_action_pressed(_rc):
			_is_right_clicking = false

func _on_mouse_enter():
	_is_hovering = true

func _on_mouse_exit():
	_is_hovering = false

func _setup_actions():
	if not InputMap.has_action(_lc):
		InputMap.add_action(_lc)
		var ev = InputEvent()
		ev.type = InputEvent.MOUSE_BUTTON
		ev.button_index = BUTTON_LEFT
		ev.doubleclick = false
		InputMap.action_add_event(_lc,ev)
	
	if not InputMap.has_action(_rc):
		InputMap.add_action(_rc)
		var ev = InputEvent()
		ev.type = InputEvent.MOUSE_BUTTON
		ev.button_index = BUTTON_RIGHT
		ev.doubleclick = false
		InputMap.action_add_event(_rc,ev)

func is_hovering():
	return _is_hovering

func get_last_mouse_position():
	return _last_mouse_position

func set_hover_emission_rate(p_hover_rate):
	_hover_emission_rate = p_hover_rate

func get_hover_emission_rate():
	return _hover_emission_rate

func is_left_clicking():
	return _is_left_clicking

func is_right_clicking():
	return _is_right_clicking