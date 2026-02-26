extends RichTextLabel

@onready var anim = $"AnimationPlayer"

func start():
	text = "[center]Repair![/center]"
	anim.play("start")

func lose():
	text = "[center]Time's up...[/center]"
	anim.play("start")

func fall():
	text = "[center]You fell...[/center]"
	anim.play("start")

func win():
	text = "[center]House repaired![/center]"
	anim.play("start")
