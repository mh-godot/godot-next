tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HoverContainer", "Container", preload("res://addons/godot-next/gui/containers/HoverContainer/HoverContainer.gd"), preload("res://addons/godot-next/gui/containers/HoverContainer/icon_hover_container.png"))
	add_custom_type("BaseSwitcher", "Container", preload("res://addons/godot-next/node_manipulation/BaseSwitcher/BaseSwitcher.gd"), preload("res://addons/godot-next/node_manipulation/BaseSwitcher/icon_base_switcher.png"))
	add_custom_type("ControlSwitcher", "Container", preload("res://addons/godot-next/gui/navigation/ControlSwitcher/ControlSwitcher.gd"), preload("res://addons/godot-next/gui/navigation/ControlSwitcher/icon_control_switcher.png"))

func _exit_tree():
	remove_custom_type("HoverContainer")
	remove_custom_type("ControlSwitcher")
	remove_custom_type("BaseSwitcher")
