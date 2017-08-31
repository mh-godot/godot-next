tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("HoverContainer", "Container", preload("res://addons/godot-next/gui/containers/HoverContainer/HoverContainer.gd"), preload("res://addons/godot-next/gui/containers/HoverContainer/icon_hover_container.png"))

func _exit_tree():
	remove_custom_type("HoverContainer")
