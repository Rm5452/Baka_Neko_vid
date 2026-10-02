tool
extends Control

var plugin:EditorPlugin = null
func _set_plugin(item:EditorPlugin):
	if item:
		plugin = item

const DIRCTION_SAVE_DATA = "res://addons/Baka_Neko_vid/temp/data.tmp"
var ffmpeg_exe = ProjectSettings.globalize_path("res://addons/Baka_Neko_vid/bin/ffmpeg.exe")

export var size_window = Vector2()

onready var explor_system:FileDialog = $Explor_system
onready var explor_res:FileDialog = $Explor_res
onready var dirction_system = $Body/Contener_dirction_system/Dirction_system
onready var dirction_res = $Body/Contener_dirction_Res/Dirction_res
onready var console:TextEdit = $Body/Console

var data:Dictionary = {
	size = Vector2()
}

var Root:Dictionary = {
	E = null,
	I = null,
	Ex = null
}

func _ready():
	data["size"] = size_window
	rect_min_size = data["size"]
	pass

var commend:String

func _on_Button_change_dir_system_pressed():
	explor_system.show()
	explor_system.current_dir = explor_system.current_dir

func _on_Explor_system_files_selected(paths):
	dirction_system.text = str(paths[0])
	Root["I"] = paths[0]

func _on_Button_change_dir_res_pressed():
	explor_res.show()
	explor_res.current_dir = explor_res.current_dir

func _on_Explor_res_file_selected(path):
	dirction_res.text = str(path)
	var my_path = ProjectSettings.globalize_path(path)
	Root["E"] = my_path
	Root["Ex"] = (path.to_lower()).get_extension()


func _on_Button_start_pressed():
	if Root["I"] == "" || Root["I"] == null:
		console.text += "\n|-> Dirction of video is 404"
	
	match Root["Ex"]:
		"ogv":
			ffmpeg_excuteing([
				"-i",
				Root["I"],
				 "-c:v",
				"libtheora",
				"-q:v",
				"7",
				"-c:a",
				"libvorbis",
				"-q:a",
				"5",
				Root["E"]
			])
			
			console.text += "\n|-> the : " + str(Root["I"])
			pass
		"webm":
			ffmpeg_excuteing([
				"-i", Root["I"],
				"-map", "0:v:0",
				"-map", "0:a:0?",
				"-c:v", "libvpx",
				"-crf", "5",
				"-b:v", "0",
				"-deadline", "good",
				"-cpu-used", "4",
				"-c:a", "libvorbis",
				"-q:a", "5",
				"-pix_fmt", "yuv420p",
				Root["E"]
			])
			
			console.text += "\n|-> the : " + str(Root["I"])
			pass
		_:
			console.text += "\n|-> Error is not (ogv, webm)"
			pass

func _on_Console_cursor_changed():
	console.scroll_vertical = console.get_line_count()

func ffmpeg_excuteing(commnds:Array = []):
	var out:Array = []
	var err_ex = OS.execute(ffmpeg_exe, commnds, true, out)
	console.text += "\n|-> OUTPUT:"
	console.text += "\n" + str(out)
	console.text += "\n|-> Code the <i>: " + str(err_ex)
	if err_ex == 0:
		console.text += "\n|-> Good"
		if plugin != null:
			plugin.get_editor_interface().get_resource_filesystem().scan()
		else:
			console.text += "\n|-> Please note that the files were not updated"
			print("=> Please note that the files were not updated <=")
		return true
		pass
	else :
		console.text += "\n|-> Alert <Code: 500>"
		return false
		pass
	pass

