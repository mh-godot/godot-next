# Contributors
# - willnationsdev
# 
# Description:
# ControlSwitcher lets you cycle through all child nodes and, assuming they are Control nodes, 
# set their visibility or focus properties accordingly as you move forward/backward in the list.
# It also lets you invert these modifications as well as have the cycling either stop at boundaries
# or loop back around to the other side.

extends "res://addons/godot-next/node_manipulation/BaseSwitcher/BaseSwitcher.gd"

enum { SWITCH_VISIBILITY, SWITCH_FOCUS, SWITCH_CUSTOM}

export(int, "Visibility", "Focus", "Custom") var switch_type = SWITCH_VISIBILITY setget set_switch_type

export var custom_switch_name = ""

func _enter_tree():
	find_targets(!name_switch.empty())
	apply()

func _ready():
	find_targets(!name_switch.empty())
	apply()

func set_switch_type(p_type):
	if p_type in [SWITCH_VISIBILITY, SWITCH_FOCUS, SWITCH_CUSTOM]:
		switch_type = p_type
	else:
		switch_type = SWITCH_VISIBILITY

func find_targets(p_use_name):
	targets = get_children()
	if targets.size() > 0:
		if p_use_name:
			for i_target in range(0,targets.size()):
				if targets[i_target].get_name() == name_switch:
					index_switch = i_target
		else:
			if allow_cycles:
				index_switch = index_switch % targets.size()
			else:
				index_switch = clamp(index_switch,0,targets.size()-1)
	if (automatic): apply()

func apply():
	if switch_type == SWITCH_VISIBILITY: _apply_visibility()
	elif switch_type == SWITCH_FOCUS: _apply_focus()
	elif switch_type == SWITCH_CUSTOM and has_method(custom_switch_name):
		call(custom_switch_name)

func _apply_focus():
	for i_target in range(0,targets.size()):
		var condition = i_target == index_switch
		if invert:
			if condition:
				targets[i_target].release_focus()
			else:
				targets[i_target].grab_focus()
		elif condition:
			targets[i_target].grab_focus()

func _apply_visibility():
	for i_target in range(0,targets.size()):
		var condition = i_target == index_switch
		targets[i_target].visible = (!condition if invert else condition)

