tool
extends Control

onready var animation_player = $AnimationPlayer
var therd = Thread.new()
var is_end = false
onready var alert = $Alert
var ex = 0

var BIN_EXE = ProjectSettings.globalize_path("res://addons/Baka_Neko_vid/bin/7z.exe")
var paths:Dictionary = {
	my_temp_bin = "res://addons/Baka_Neko_vid/bin/7z.bin",
	ffmeg_file = "res://addons/Baka_Neko_vid/bin/ffmpeg.exe",
	ffmpeg = ProjectSettings.globalize_path("res://addons/Baka_Neko_vid/assets/ffmpeg.7z"),
	dir_exit = ProjectSettings.globalize_path("res://addons/Baka_Neko_vid/bin/")
}

var command:Array = ["x", paths["ffmpeg"], "-o" + paths["dir_exit"]]

var out:Array = []
func _ready():
	var Dir_7z = File.new()
	if !Dir_7z.file_exists(BIN_EXE):
		var err = rename_my_file(paths["my_temp_bin"], BIN_EXE)
		if err == false:
			print("-----------------------------------------")
			print("|-> errore: res://addons/Baka_Neko_vid/scripts/import_cmd_tool.gd")
			print("|--> in var => my_temp_bin (_ready())")
			
			alert.dialog_text = str("error <404>")
			alert.show()
			
			return
	
	animation_player.play("move")
	var file = File.new()
	if !file.file_exists(paths["ffmeg_file"]):
		therd.start(self, "run")
		file.close()
	else:
		file.close()
		end()
	pass
	
	Dir_7z.close()

func _process(delta):
	if is_end:
		is_end = false
		
		if ex != 0:
			alert.show()
			alert.dialog_text = "Error (7z) : code => " + str(ex)
		else:
			end()

func end():
	animation_player.play("end")
	yield(get_tree().create_timer(2), "timeout")
	if therd.is_active():
		therd.wait_to_finish()
	queue_free()

func run(data):
	ex = OS.execute(BIN_EXE, command, true, out)
	is_end = true

func _on_PopupDialog_confirmed():
	if therd.is_active():
		therd.wait_to_finish()
	queue_free()

func rename_my_file(old_name = null, new_name = null):
	if old_name == null || new_name == null: return false
	var dirctory = Directory.new()
	if dirctory.file_exists(old_name):
		var err = dirctory.rename(old_name, new_name)
		if err == OK:
			print("=======================( Rename is 200 )=======================")
			return true
		else: return false
	else: return false
	pass
