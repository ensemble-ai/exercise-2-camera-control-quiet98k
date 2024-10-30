class_name PositionLockLerp
extends CameraControllerBase

@export var follow_speed:float
@export var catchup_speed:float = 100
@export var leash_distance:float = 20

var cross_width:float = 5
var cross_height:float = 5

var velocity:Vector3

func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true
	

func _process(delta: float) -> void:
	if !current:
		return
	
	if draw_camera_logic:
		draw_logic()
	follow_speed = target.speed * 0.75
	var tpos = target.global_position
	var cpos = global_position
	
	#var direction = (tpos-cpos).limit_length(1)
	var direction = cpos.direction_to(tpos)
	var distance = cpos.distance_to(tpos)
	
	var speed: float
	if target.velocity.length() > 0.1:
		speed = follow_speed
	else:
		speed = catchup_speed

	global_position += direction * speed * delta
	
	
	var diff_between_left_edges = (tpos.x - target.WIDTH / 2.0) - (cpos.x - leash_distance / 2.0)
	if diff_between_left_edges < 0:
		global_position.x += diff_between_left_edges
	#right
	var diff_between_right_edges = (tpos.x + target.WIDTH / 2.0) - (cpos.x + leash_distance / 2.0)
	if diff_between_right_edges > 0:
		global_position.x += diff_between_right_edges
	#top
	var diff_between_top_edges = (tpos.z - target.HEIGHT / 2.0) - (cpos.z - leash_distance / 2.0)
	if diff_between_top_edges < 0:
		global_position.z += diff_between_top_edges
	#bottom
	var diff_between_bottom_edges = (tpos.z + target.HEIGHT / 2.0) - (cpos.z + leash_distance / 2.0)
	if diff_between_bottom_edges > 0:
		global_position.z += diff_between_bottom_edges
		
	super(delta)
	


func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var half_width: float = cross_width / 2
	var half_height: float = cross_height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-half_width, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(half_width, 0, 0))

	immediate_mesh.surface_add_vertex(Vector3(0, 0, -half_height))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, half_height))
	immediate_mesh.surface_end()

	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	
	#mesh is freed after one update of _process
	await get_tree().process_frame
	mesh_instance.queue_free()
