tool
extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func render(content : String):
	var result = ""
	var bolded = []
	var italics = []
	var striked = []
	var coded = []
	var linknames = []
	var images = []
	var links = []
	var lists = []
	var underlined = []
	
	var regex = RegEx.new()
	regex.compile('\\*\\*(?<boldtext>.*)\\*\\*')
	result = regex.search_all(content)
	if result:
		for res in result:
			bolded.append(res.get_string("boldtext"))
	
	regex.compile('\\_\\_(?<underlinetext>.*)\\_\\_')
	result = regex.search_all(content)
	if result:
		for res in result:
			underlined.append(res.get_string("underlinetext"))
	
	regex.compile("\\*(?<italictext>.*)\\*")
	result = regex.search_all(content)
	if result:
		for res in result:
			italics.append(res.get_string("italictext"))
	
	regex.compile("~~(?<strikedtext>.*)~~")
	result = regex.search_all(content)
	if result:
		for res in result:
			striked.append(res.get_string("strikedtext"))
	
	regex.compile("`(?<coded>.*)`")
	result = regex.search_all(content)
	if result:
		for res in result:
			coded.append(res.get_string("coded"))
	
	# No idea what is this
	regex.compile("[+-*](?<element>\\s.*)")
	result = regex.search_all(content)
	if result:
		for res in result:
			lists.append(res.get_string("element"))
	
	regex.compile("(?<img>!\\[.*?\\))")
	result = regex.search_all(content)
	if result:
		for res in result:
			images.append(res.get_string("img"))
	
	# No idea how this works
	regex.compile("\\[(?<linkname>.*?)\\]|\\((?<link>[h\\.]\\S*?)\\)")
	result = regex.search_all(content)
	if result:
		for res in result:
			if res.get_string("link")!="":
				links.append(res.get_string("link"))
			if res.get_string("linkname")!="":
				linknames.append(res.get_string("linkname"))
	
	for bold in bolded:
		content = content.replace("**"+bold+"**","[b]"+bold+"[/b]")
	for italic in italics:
		content = content.replace("*"+italic+"*","[i]"+italic+"[/i]")
	for strik in striked:
		content = content.replace("~~"+strik+"~~","[s]"+strik+"[/s]")
	for underline in underlined:
		content = content.replace("__"+underline+"__","[u]"+underline+"[/u]")
	for code in coded:
		content = content.replace("`"+code+"`","[code]"+code+"[/code]")
	for image in images:
		var substr = image.split("(")
		var imglink = substr[1].rstrip(")")
		content = content.replace(image,"[img]"+imglink+"[/img]")
	for i in links.size():
		content = content.replace("["+linknames[i]+"]("+links[i]+")","[url="+links[i]+"]"+linknames[i]+"[/url]")
	for element in lists:
		if content.find("- "+element):
			content = content.replace("-"+element,"[indent]-"+element+"[/indent]")
		if content.find("+ "+element):
			content = content.replace("+"+element,"[indent]-"+element+"[/indent]")
		if content.find("* "+element):
			content = content.replace("+"+element,"[indent]-"+element+"[/indent]")
	
	bbcode_text = content
	
