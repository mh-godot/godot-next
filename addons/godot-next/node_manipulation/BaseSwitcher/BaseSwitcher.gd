extends Node

export(bool) var automatic = true    # Whether to automatically apply switch when settings are changed
export(bool) var allow_cycles = true # Whether to cycle to the other end of the set when passed the edge
export(bool) var invert = false      # Whether to invert the application function's effects

export(int) var index_switch = 0 setget set_index_switch   # The index of the selected node
export(String) var name_switch = "" setget set_name_switch # The name of the selected node

var targets = []  # The total set of nodes being examined

var _is_first_update = true # Without this, "original" in setters blocks editor-defined values

# Needed for tool functionality
func _enter_tree():
	_is_first_update = false # this will end up running LAST, after any derived version's _enter_tree methods

# Needed for runtime functionality, not a big deal if it runs twice
func _ready():
	pass

func set_index_switch(p_index):
	var original = index_switch if !_is_first_update else p_index
	index_switch = p_index
	find_targets(false)
	# Only leave side effects if the new value results in identified targets
	if not targets.empty():
		name_switch = targets[p_index].get_name()
	else:
		index_switch = original
	
func set_name_switch(p_name):
	var original = name_switch if !_is_first_update else p_name
	name_switch = p_name
	find_targets(true)
	# Only leave side effects if the new value results in identified targets
	if not targets.empty():
		index_switch = targets.find(p_name)
	else:
		name_switch = original

func next():
	index_switch += 1
	if (allow_cycles): index_switch = index_switch % targets.size()
	else: index_switch = clamp(index_switch,0,targets.size()-1)
	if (automatic): apply()

func previous():
	index_switch -= 1
	if (allow_cycles): index_switch = (index_switch+targets.size()) % targets.size()
	else: index_switch = clamp(index_switch,0,targets.size()-1)
	if (automatic): apply()

func apply():
	pass

func find_targets(p_use_name):
	pass

func get_target():
	return targets[index_switch] if !targets.empty() else null