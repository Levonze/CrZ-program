# plugin.gd
@tool
extends EditorPlugin

var kl_dos_platform: EditorExportPlatformExtension

func _enter_tree() -> void:
	kl_dos_platform = preload("res://addons/customexport/custom_exporter.gd").new()
	# Adds the platform to the 'Add...' list in the Project > Export dialog
	add_export_platform(kl_dos_platform)

func _exit_tree() -> void:
	# Cleanup to avoid duplicate entries when re-enabling the plugin
	remove_export_platform(kl_dos_platform)
