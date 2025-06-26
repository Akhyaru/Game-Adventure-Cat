extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_stage_1_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game4.tscn")

func _on_stage_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game5.tscn")

func _on_stage_3_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game6.tscn")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/difficulty.tscn")
