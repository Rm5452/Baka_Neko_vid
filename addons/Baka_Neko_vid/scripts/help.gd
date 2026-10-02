tool
extends Button
var dir_help = ProjectSettings.globalize_path("res://addons/Baka_Neko_vid/help/index.html")
func _on_help_pressed():
	OS.shell_open("file:///" + dir_help)
	pass # Replace with function body.
