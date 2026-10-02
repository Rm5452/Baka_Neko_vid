tool
extends EditorPlugin

const BUTTON_NAME = "BakaNekoImportVideo"
const WIN_NAME = "WinExportTheVideo"
var window_exorting = preload("res://addons/Baka_Neko_vid/UI/window_exporting.tscn")
var resorc = preload("res://addons/Baka_Neko_vid/assets/img/smal_icon.png")

var ffmpeg_file = "res://addons/Baka_Neko_vid/bin/ffmpeg.exe"
var instance_cmd_tool = null

var instans:Dictionary = {}
var INDEX_BUTTON:Button
var positioButton = CONTAINER_TOOLBAR
var size_editor = get_editor_interface().get_base_control().rect_size
var the_win = null

func _ready():
	var dir = File.new().file_exists(ffmpeg_file)
	if !dir:
		var importing_cmd = preload("res://addons/Baka_Neko_vid/UI/import_cmd_tool.tscn")
		instance_cmd_tool = importing_cmd.instance()
		get_editor_interface().get_base_control().add_child(instance_cmd_tool)
	pass

func _enter_tree():
	_remove_button()
	if window_exorting != null:
		var win = window_exorting.instance()
		if win:
			the_win = win
			if the_win.has_method("_set_plugin"):
				if is_instance_valid(the_win): the_win._set_plugin(self)
			win.name = WIN_NAME
			win.size_window = Vector2(size_editor.x / 4, size_editor.y /2)
			get_editor_interface().get_base_control().add_child(win)
	
	INDEX_BUTTON = Button.new()
	INDEX_BUTTON.name = BUTTON_NAME
	INDEX_BUTTON.icon = resorc
	INDEX_BUTTON.text = str("Import")
	add_control_to_container(positioButton, INDEX_BUTTON)
	INDEX_BUTTON.connect("button_down", self, "__mainBtn")
	
	
	var base = get_editor_interface().get_base_control()
	the_win = base.find_node(WIN_NAME, true, false)

func _exit_tree():
	_remove_button()
	if instance_cmd_tool != null:
		instance_cmd_tool = null
	if is_instance_valid(the_win):
		the_win.queue_free()

func __mainBtn():
	if is_instance_valid(the_win):
		the_win.show()
	pass

func _remove_button():
	if INDEX_BUTTON and is_instance_valid(INDEX_BUTTON):
		remove_control_from_container(positioButton, INDEX_BUTTON)
		INDEX_BUTTON.queue_free()
		INDEX_BUTTON = null
	
	var base = get_editor_interface().get_base_control()
	var old_button = base.find_node(BUTTON_NAME, true, false)
	if old_button and is_instance_valid(old_button):
		remove_control_from_container(positioButton, old_button)
		old_button.queue_free()
