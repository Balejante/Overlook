extends CharacterBody2D

@onready var navigation_agent = $NavigationAgent2D
@export var character_to_chase: CharacterBody2D
@onready var sprite = $enemySprite
const SPEED = 150.0

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

func _physics_process(delta):
	navigation_agent.target_position = character_to_chase.global_position
	velocity = global_position.direction_to(navigation_agent.get_next_path_position()) * SPEED
	if !Global.is_chatting:
		move_and_slide()
	animate()
