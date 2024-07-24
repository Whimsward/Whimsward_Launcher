extends Vendor

signal reported


@onready var dialog = $Dialog

func _ready():
	pass


func deploy_items():
	pass


func on_item_signalled():
	pass



func _on_show_setting_button_pressed():
	dialog.show()


func _on_dialog_submitted(selection):
	print(selection)
