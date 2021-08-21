extends RigidBody2D

export var min_speed = 90
export var max_speed = 130

func _ready() -> void:
	$VisibilityNotifier2D.connect('screen_exited', self, '_on_VisibilityNotifier2D_screen_exited')

	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
