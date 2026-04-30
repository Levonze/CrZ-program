# kl_dos_platform.gd
@tool
extends EditorExportPlatformExtension

# Returns the name displayed in the "Add..." dropdown menu
func _get_name() -> String:
	return "KL_DOS 1.2"

# Returns the logo displayed in the export menu
func _get_logo() -> Texture2D:
	return preload("res://circle.svg")

# Defines the file extension for the final export
func _get_binary_extensions(preset: EditorExportPreset) -> PackedStringArray:
	return PackedStringArray(["kapp", "com"])

# Core logic executed when "Export Project" is clicked
func _export_project(preset: EditorExportPreset, debug: bool, path: String, flags: int) -> Error:
	# Use built-in helpers to save the project data as a PCK or ZIP
	var err = save_pack(preset, debug, path.get_basename() + ".pck")
	if err != OK:
		return err
	
	# Custom logic to wrap the PCK in a KL_DOS 1.2 runner or executable
	print("Packing project for KL_DOS 1.2 at: ", path)
	return OK

func _get_export_options() -> Array[Dictionary]:
	return [{'name': "AppVersion",'type':Variant.Type.TYPE_STRING, 'required': true, 'default_value':"1.0.0"}]
