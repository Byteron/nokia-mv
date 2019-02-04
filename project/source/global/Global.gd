extends Node2D

# References
var player = null

# Scenes
var Menu = "res://source/interface/menu/Menu.tscn"
var Level1 = "res://source/levels/Level1.tscn"
var Victory = "res://source/interface/menu/Victory.tscn"

# Resources
var heartbeat_normal = load("res://audio/sounds/heartbeat_test.ogg")
var heartbeat_faster = load("res://audio/sounds/heartbeat_faster_test.ogg")
var heartbeat_fastest = load("res://audio/sounds/heartbeat_fastest_test.ogg")
var heartbeat_critical = load("res://audio/sounds/heartbeat_critical_test.ogg")