class_name PositionLock
extends CameraControllerBase


@export var cross_width:float = 10.0
@export var cross_height:float = 10.0


func _ready() -> void:
	super()
	position = target.position
	draw_camera_logic = true
	

func _process(delta: float) -> void:
	if !current:
		position = target.position
		return
	
	if draw_camera_logic:
		draw_logic()
	
	var tpos = target.global_position
	var cpos = global_position
	
	#boundary checks
	#left
	
	var horizontal_diff = tpos.x - cpos.x
	if horizontal_diff !=  0:
		global_position.x += horizontal_diff
	#top
	var vertical_diff = tpos.z - cpos.z
	if vertical_diff !=  0:
		global_position.z += vertical_diff
	
		
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
