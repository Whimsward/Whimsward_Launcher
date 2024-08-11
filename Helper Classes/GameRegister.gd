class_name GameRegister extends Resource
##A resource for me to reference and possibly build a menu to select 20-game-challenge sub-projects.

enum Games {GAME_1 = 1,GAME_2,GAME_3,GAME_4,GAME_5,GAME_6,GAME_7,GAME_8,GAME_9,GAME_10}

@export var games : Dictionary = {
	"Twenty Games" : challenges,
	"Path of the Digger" : "res://Ardor and the World Undone/Path of the Digger/run_potd.tscn",
	"Half-Remembered Wood" : "res://Ardor and the World Undone/The Half-Remembered Wood/run_hrw.tscn",
	"DOM" : "res://DOM/dom_edit.tscn"
}

const challenges : Dictionary = {
	"Game 1" : {"Pong" : "", "Flappy Bird" : ""},
	"Game 2" : {"Breakout" : "", "Jetpack Joyride" : ""},
	"Game 3" : {"Space Invaders" : "", "Frogger" : "", "River Raid" : ""},
	"Game 4" : {"Asteroids" : "", "Spacewar!" : "", "Indy 500" : ""},
	"Game 5" : {"Pac Man" : "", "Tic-Tac-Toe" : "", "Conway's Game of Life" :""}, 
	"Game 6" : {"Super Mario Bros." : "","Pitfall" : "", "VVVVVV" : ""},
	"Game 7" : {"Worms":"","Dig Dug":""},
	"Game 8" : {"Super Monkey Ball":"","Star Fox":"","Crash Bandicoot":""},
	"Game 9" : {"Wolfenstein or Doom":"","Mario Kart":""},
	"Game 10" : {"Minecraft":"","Portal":""},
}

##Return the [String]ified version of [Game]s
func sel(index : int) -> String:
	return Games.find_key(index).capitalized()


##Call [GameRegister.sel()] to read the value of a key in challenges with an index
func read_challenges(index : int):
	return challenges[sel(index)]


##Instantiate a [DirAccess] [Object].
static func read_files(path : String):
	var files = DirAccess.get_files_at(path)
	return files


##Call to filter out [invalid_strings] from the the result of a [Call] to [DirAccess.get_directories_at]
##a given [path].
static func constrain_directories(path : String,invalid_strings : PackedStringArray):
	var result = DirAccess.get_directories_at(path).duplicate()
	for dir in result:
		if invalid_strings.find(dir) >= 0:
			result.remove_at(result.find(dir))
	return result
