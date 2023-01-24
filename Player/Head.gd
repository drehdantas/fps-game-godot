extends Spatial


export(NodePath) var cam_path := NodePath("Camera")
onready var cam: Camera = get_node(cam_path)

export var mouse_sensitivity := 2.0
export var y_limit := 90.0
var mouse_axis := Vector2()
var rot := Vector3()

var ammo : int = 666
onready var bulletPistol = load("res://Weapons/BulletPistol.tscn")
onready var muzzle : Spatial = get_node("Camera/Muzzle")


func _process(delta):
	# check to see if we have shot
	if Input.is_action_just_pressed("shoot") and ammo > 0:
		shoot()
	pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mouse_sensitivity = mouse_sensitivity / 1000
	y_limit = deg2rad(y_limit)


# Called when there is an input event
func _input(event: InputEvent) -> void:
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		mouse_axis = event.relative
		camera_rotation()


func camera_rotation() -> void:
	# Horizontal mouse look.
	rot.y -= mouse_axis.x * mouse_sensitivity
	# Vertical mouse look.
	rot.x = clamp(rot.x - mouse_axis.y * mouse_sensitivity, -y_limit, y_limit)
	
	get_owner().rotation.y = rot.y
	rotation.x = rot.x

func shoot ():
	#change bullet
	var bullet
#	if(current_weapon==1):
#		bullet = bulletShotgun.instance()
#	elif(current_weapon==2):
#		bullet = bulletMachinegun.instance()
#	elif(current_weapon==3):
	bullet = bulletPistol.instance()
	
	#spawn a new bullet and move it 	
	get_node("/root/L_Main").add_child(bullet)
	bullet.set_global_transform(muzzle.get_global_transform())
	ammo -= 1

#	ui.update_ammo_text(ammo)
	pass
