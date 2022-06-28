tool
extends Control

onready var previewer: RichTextLabel = $MarginContainer/VBoxContainer/HSplitContainer/Previewer
onready var writer: TextEdit = $MarginContainer/VBoxContainer/HSplitContainer/Writer
onready var file_name: LineEdit = $MarginContainer/VBoxContainer/HBoxContainer/LineEdit


# Called when the node enters the scene tree for the first time.
func _ready():
	previewer.bbcode_enabled = true
	previewer.render(writer.text)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Writer_text_changed():
	previewer.render(writer.text)


func _on_Save_pressed():
	if file_name.text:
		var file = File.new()
		file.open("res://"+file_name.text+".md", File.WRITE)
		file.store_string(writer.text)
		file.close()


func _on_Open_pressed():
	if file_name.text:
		var file = File.new()
		file.open("res://"+file_name.text+".md", File.READ_WRITE)
		writer.text = file.get_as_text()
		file.close()
