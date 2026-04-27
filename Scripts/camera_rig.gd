extends SpringArm3D

@onready var camera: Camera3D = $Camera3D
var turn_rate := 150.0
var mouse_input : Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spring_length = camera.position.z
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var look_input := Input.get_vector("view_left", "view_right", "view_up", "view_down")
	look_input = turn_rate * look_input * delta
	look_input += mouse_input
	mouse_input = Vector2()
	rotation_degrees.x += look_input.y
	rotation_degrees.y += look_input.x
	rotation_degrees.x = clampf(rotation_degrees.x, -70, 50)
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input = event.relative
	elif event is InputEventKey and event.keycode == KEY_ESCAPE and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
