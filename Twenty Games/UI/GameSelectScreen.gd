extends Window

@export var regis : GameRegister
@export var opt_stack : VBoxContainer


func _ready(): #create an OptionButton for each entry in the GameRegister's challenges.
	for i in regis.challenges:
		var challenge = OptionButton.new()
		challenge.fit_to_longest_item = true
		challenge.add_item(i)
		challenge.add_separator()
		if regis.challenges[i] is Dictionary:
			for g in regis.challenges[i]:
				challenge.add_item(g)
		opt_stack.add_child(challenge)
