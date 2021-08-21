extends Area2D

signal hit

export var speed: float = 250
var screen_size: Vector2

func _ready() -> void:
	hide()
	screen_size = get_viewport_rect().size
	connect('body_entered', self, '_on_Player_body_entered')

func _process(delta: float) -> void:
	var velocity = Vector2()
	
	velocity.y = int(Input.is_action_pressed('ui_down')) - int(Input.is_action_pressed('ui_up'))
	velocity.x = int(Input.is_action_pressed('ui_right')) - int(Input.is_action_pressed('ui_left'))
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	if velocity.x  != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_v = velocity.y > 0
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

func _on_Player_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred('disabled', true)

func start(pos: Vector2) -> void:
	position = pos
	show()
	$CollisionShape2D.disabled = false
