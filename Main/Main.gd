extends Node2D

var total : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_score(total)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	total += delta
	update_score(total)

func update_score(current_score : float) -> void:
	$Score.text = str(current_score)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_right"):
		print("Right arrow!")
	if event.is_action_pressed("ui_left"):
		print("left arrow!")
	if event.is_action_pressed("ui_up"):
		print("up arrow!")
	if event.is_action_pressed("ui_down"):
		print("down arrow!")

const SPEED : int = 100
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		# Move enquanto a tecla estiver pressionada
		position.x += SPEED * delta
	if Input.is_action_pressed("ui_left"):
		# Move enquanto a tecla estiver pressionada
		position.x -= SPEED * delta
	if Input.is_action_pressed("ui_up"):
		# Move enquanto a tecla estiver pressionada
		position.y -= SPEED * delta
	if Input.is_action_pressed("ui_down"):
		# Move enquanto a tecla estiver pressionada
		position.y += SPEED * delta
