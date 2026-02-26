extends DirectionalLight3D

func start():
	$"AnimationPlayer".play("set")

func stop():
	$"AnimationPlayer".stop(true)

func instant_set():
	$"AnimationPlayer".stop(true)
	$"AnimationPlayer".play("set_instant")
