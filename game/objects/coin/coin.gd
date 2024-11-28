extends Area2D;

@export_category("Objects")
@export var audioStream : AudioStreamPlayer2D;
@export var sprite : Sprite2D;

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.player.coins += 1;
		audioStream.play();
		sprite.visible = false;

func _on_audio_stream_finished() -> void:
	queue_free();
