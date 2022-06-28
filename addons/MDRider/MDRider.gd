tool
extends EditorPlugin

var interface: Control

func _enter_tree():
	interface = preload("res://addons/MDRider/Canvas.tscn").instance()
	get_editor_interface().get_editor_viewport().add_child(interface)
	make_visible(false)
#	add_control_to_dock(EditorPlugin.DOCK_SLOT_LEFT_UR, SCENE)


func _exit_tree():
	if interface:
		interface.queue_free()

func has_main_screen() -> bool:
	return true

func get_plugin_name() -> String:
	return "MD Rider"

func get_plugin_icon() -> Texture:
	return preload("res://addons/MDRider/MD Icon.png")

func make_visible(visible: bool) -> void:
	if interface:
		interface.visible = visible
