extends CharacterBody2D

@export var speed = 250.0

@onready var sprite = $PlayerSprite
var twins_in_range = false
var chatting = false

@export var character_to_chase: CharacterBody2D
@onready var navigation_agent = $NavigationAgent2D

var item_detection = false

func get_8way_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
func animate():
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()

func move_8way(delta):
	if !Global.is_chatting:
		get_8way_input()
	animate()
	#move_and_slide()

#func _physics_process(delta):
	#move_8way(delta)

func _physics_process(delta):
	if !Global.is_chatting:
		chatting = false
		get_8way_input()
	animate()
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		#velocity = velocity.bounce(collision_info.get_normal())
		move_and_collide(velocity * delta * 10)
	#move_and_slide()
	if twins_in_range == true:
		if Input.is_action_just_pressed("ui_accept"):
			Global.is_chatting = true
			print(Global.is_chatting, "conversa começou")
			if !chatting:
				chatting = true
				DialogueManager.show_dialogue_balloon(load("res://dialog1.dialogue"),"start")
			return
	if item_detection == true:
		if Input.is_action_just_pressed("ui_accept"):
			global.item_taken = true

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		get_tree().change_scene_to_file("res://Game/derrota.tscn")


func _on_area_2d_body_entered(body):
	if body.has_method("ghost"):
		twins_in_range = true


func _on_area_2d_body_exited(body):
	if body.has_method("ghost"):
		twins_in_range = false


func _on_item_detection_area_body_entered(body):
	if body.has_method("player"):
		print("item detection")
		item_detection = true # Replace with function body.


func _on_item_detection_area_body_exited(body):
	if body.has_method("player"):
		print("item detection")
		item_detection = false # Replace with function body.
