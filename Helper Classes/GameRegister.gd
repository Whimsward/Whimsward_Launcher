class_name GameRegister extends Resource
##A resource for me to reference and possibly build a menu to select 20-game-challenge sub-projects.

enum Games {GAME_1 = 1,GAME_2,GAME_3,GAME_4,GAME_5,GAME_6,GAME_7,GAME_8,GAME_9,GAME_10}

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

var the_world_undone = "res://Ardor and the World Undone/"
var path_of_the_digger = "res://Ardor and the World Undone/Path of the Digger/"
var half_remembered_wood = "res://Ardor and the World Undone/The Half-Remembered Wood/"
var run_potd = load("res://Ardor and the World Undone/Path of the Digger/run_potd.tscn")
var run_hrw = load("res://Ardor and the World Undone/The Half-Remembered Wood/run_hrw.tscn")

var dom = "res://DOM"
var dom_edit = load("res://DOM/dom_edit.tscn")


#return the stringified version of Games
func sel(index : int) -> String:
	return Games.find_key(index).capitalized()


#use sel() to read the value of a key in challenges with an index
func read_challenges(index : int):
	return challenges[sel(index)]


static func read_files(path : String):
	var files = DirAccess.get_files_at(path)
	return files


static func constrain_directories(path : String,invalid_strings : PackedStringArray):
	var result = DirAccess.get_directories_at(path).duplicate()
	for dir in result:
		if invalid_strings.find(dir) >= 0:
			result.remove_at(result.find(dir))
	return result

