extends Node
const SAVE_PATH = "res://progress.bin";

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE);
	var data : Dictionary = {
		"playHP": Game.playHP,
		"Gold": Game.Gold,
	}
	var jstr = JSON.stringify(data);
	file.store_line(jstr);
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ);
	if file.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line());
			if current_line:
				Game.playHP = current_line['playHP'];
				Game.Gold = current_line['Gold'];
			
