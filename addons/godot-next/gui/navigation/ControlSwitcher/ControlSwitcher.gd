extends "res://addons/godot-next/node_manipulation/BaseSwitcher/BaseSwitcher.gd"

enum { SWITCH_VISIBILITY = 0, SWITCH_FOCUS = 1 }

export(int, "Visibility", "Focus") var switch_type = SWITCH_VISIBILITY setget set_switch_type

func _enter_tree():
	find_targets(!name_switch.empty())
	apply()

func _ready():
	find_targets(!name_switch.empty())
	apply()

func set_switch_type(p_type):
	if p_type in [SWITCH_VISIBILITY, SWITCH_FOCUS]:
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

func apply():
	if switch_type == SWITCH_VISIBILITY: _apply_visibility()
	elif switch_type == SWITCH_FOCUS: _apply_focus()

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
		targets[i_target].set_hidden( !(!condition if invert else condition) )
