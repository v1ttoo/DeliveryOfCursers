extends CharacterBody2D;
class_name Player;

@export_category("Variables")
@export var speed : float = 5000.0;
@export var gravity : float = 600.0;
@export var jumpForce : float = 8000.0;

@export_category("Objects")
@export var animation : AnimationPlayer;
@export var sprite : Sprite2D;

#Local Variables
var coins : int = 0;
var keys : int = 0;
enum States {Idle, Walking};
var currentState : States = States.Idle;

func _ready() -> void:
	Global.player = self;

func _physics_process(delta: float) -> void:
	move(delta);
	stateMachine();
	
	print(keys);

func move(delta : float) -> void:
	#Horizontal Movement
	var leftKey : bool = Input.is_action_pressed("left");
	var rightKey : bool = Input.is_action_pressed("right");
	
	var direction : int = int(rightKey) - int(leftKey);
	velocity.x = move_toward(velocity.x, (direction * speed) * delta, 300 * delta);
	
	if !is_on_floor():
		velocity.y += gravity * delta;
	
	if direction != 0:
		changeState(States.Walking);
	else:
		changeState(States.Idle);
	
	if leftKey:
		sprite.flip_h = true;
	elif rightKey:
		sprite.flip_h = false;
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jumpForce * delta;
	
	move_and_slide();


func stateMachine() -> void:
	match currentState:
		States.Idle:
			animation.play("idle");
		States.Walking:
			animation.play("walking");

func changeState(newState : States) -> void:
	if newState != currentState:
		currentState = newState;
