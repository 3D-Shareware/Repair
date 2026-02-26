extends Sprite2D

@onready var anim = $"AnimationPlayer"

func play(anim_name: String):
	anim.play(anim_name)
