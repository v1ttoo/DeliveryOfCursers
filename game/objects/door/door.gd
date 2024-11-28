extends StaticBody2D;
class_name Door;

@export_category("Objects")
@export var audioStream : AudioStreamPlayer2D;

#Local Variables
var canOpen = false;
var open = false;

func _process(_delta: float) -> void:
	if canOpen and !open:
		if Input.is_action_just_pressed("interact") and Global.player.keys > 0:
			open = true;
			audioStream.play();

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		canOpen = true;

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		canOpen = false;

func _on_audio_stream_finished() -> void:
	queue_free();
