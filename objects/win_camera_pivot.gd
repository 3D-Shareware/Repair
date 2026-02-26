extends Node3D

func play():
	$"Camera3D".current = true
	$"AnimationPlayer".play("go")

func lose():
	$"Camera3D".current = true
	$"AnimationPlayer".play("lose")
